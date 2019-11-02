import 'package:flutter/material.dart';

class LoginRegisterPages extends StatefulWidget{
  @override 
  _LoginRegisterState createState()=> _LoginRegisterState();
}
class _LoginRegisterState extends State<LoginRegisterPages>
{
  //methods
  void valicateAndSave(){

  }
  void moveToRegister(){

  }
  @override 
  Widget build (BuildContext context){
      return new Scaffold(
      //  backgroundColor: Colors.pink[50],
         resizeToAvoidBottomPadding: false,
         appBar:  new  AppBar(
           title: new Text("Presschool"),
           backgroundColor: Colors.green[300],
           
         ),
         body:  new Container(
           margin: EdgeInsets.all(15.0),
        //  decoration: new BoxDecoration(color: Colors.pinkAccent[50]),
           child:  new Form(
                 child:  new Column(
              
                crossAxisAlignment: CrossAxisAlignment.center,
                children: createInputs() + createButton(),
             ),
           ),
         ),
      );
  }
  List<Widget> createInputs(){
    return[
      SizedBox(height: 10.0,),
      logo(),
      SizedBox(height: 20.0,),
      new TextField(
      
        decoration: InputDecoration(
        //  border: OutlineInputBorder(),
          filled: true,
          fillColor: Color(0xFFF2F2F2),
          border: OutlineInputBorder(),
          labelText: 'Email',
          enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1,color: Colors.green),
        ))
      ),
     
      SizedBox(height: 15.0,),
      new TextField(
        
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF2F2F2),
          border: OutlineInputBorder(),
          labelText: 'Password',
          enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1,color: Colors.green),
      ),
        )
      ),
      SizedBox(height: 20.0,),

    ];
  }
  Widget logo()
  {
    return new Hero(
      tag: 'hero',
      child:  new CircleAvatar(
        backgroundColor:  Colors.transparent,
        radius: 110.0,
        child:  Image.asset('images/logo.png'),
      ),
    );
  }
   List<Widget> createButton(){
    return[
      new  SizedBox(
  width: 200, // specific value
  height: 50,
  child: RaisedButton(
        shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.green[900])
),
        child:  new Text("Login", style: new TextStyle(fontSize: 20.0)),
        textColor: Colors.white,
        color: Colors.green[300],
        onPressed: valicateAndSave,
      ),
),
      new FlatButton(
        child: new Text("Not have an Account? Create Account??", style:  new TextStyle(fontSize:14.0 ),),
        // textColor: Colors.white,
      //  color: Colors.pink,
        onPressed: moveToRegister,
      ),
     
    ];
  }
}