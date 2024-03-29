import 'package:blog_app/PhotoUpload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'Posts.dart';
class HomePage extends StatefulWidget
{
  HomePage({
    this.auth,
    this.onSignedOut,
  });
  final AuthImplementation auth;
  final VoidCallback onSignedOut;
  @override 
  State<StatefulWidget> createState(){
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage>
{
  List<Posts> postList=[];
  @override
  void initState(){
    super.initState();
    DatabaseReference postsRef=FirebaseDatabase.instance.reference().child("Posts");
    postsRef.once().then((DataSnapshot snap){
      var KEYS=snap.value.keys;
      var DATA= snap.value;
      postList.clear();
      for(var individualKey in KEYS)
      {
        Posts posts = new Posts
        (
          DATA[individualKey]['image'],
          DATA[individualKey]['description'],
          DATA[individualKey]['date'],
          DATA[individualKey]['time'],
        );
        postList.add(posts);


      }
      setState(() {
        print('Length: $postList.length');
      });
    });
  }
  void _logoutUser() async{
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    }
    catch(e){
      print(e.toString());
    }
  }
  void like(){

  }
  @override 
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new  AppBar(
        title: new Text('Home'),
      ),
      body:  new Container(
        child: postList.length==0? new Text("No Blog post availabel"): new ListView.builder(
          itemCount: postList.length,
          itemBuilder: (_, index){
            return PostsUI(postList[index].image,postList[index].description,postList[index].date,postList[index].time);
          }

        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.pink,
        child: new Container(
          margin:  const EdgeInsets.only(left: 70,right: 50 ),
          child: new Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            mainAxisSize:  MainAxisSize.max,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.local_car_wash),
                iconSize:  50,
                color: Colors.white,
                onPressed: _logoutUser,
              ),
                new IconButton(
                icon: new Icon(Icons.add_a_photo),
                iconSize:  40,
                color: Colors.white,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        return new UploadPhotoPage();
                      }
                    )

                   
                   );
                },
              )
            ],
          )
          
        ),
      )
    );
  }
  Widget PostsUI(String image, String description,String date, String time){
    return new Card(
      elevation:  10.0,
      margin: EdgeInsets.all(15.0),
      child: new Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           new Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
              new Text(
              date,
              style: Theme.of(context).textTheme.subtitle,
              textAlign: TextAlign.center,
            ),
            new Text(
              time,
              style: Theme.of(context).textTheme.subtitle,
              textAlign: TextAlign.center,
            )
           ],),
           SizedBox(height: 10.0,),
           new Image.network(image, fit:BoxFit.cover),
          SizedBox(height: 10.0,),
            new Text(
              description,
              style: Theme.of(context).textTheme.subhead,
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 10.0,),
              new Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
              new FlatButton(
              
              highlightColor: Colors.pink,
              child: Row( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.favorite,color: Colors.pink,),
                    Text("Like", style:  new TextStyle(fontSize:14.0 ),),
                  ],
                ),
              onPressed:null,
               ),
               new FlatButton(
              
  
              child: Row( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.mode_comment,color: Colors.black,),
                    Text("Comments", style:  new TextStyle(fontSize:14.0 ),),
                  ],
                ),
              onPressed:null,
               ),
           ],
                  
              ),
            
          ],
        ),
      )
    );
  }
}