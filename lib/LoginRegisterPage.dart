
import 'package:blog_app/DialogBox.dart';
import 'DialogBox.dart';
import 'Authentication.dart';
import 'package:blog_app/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginRegisterPages extends StatefulWidget{
  LoginRegisterPages({
    this.auth,
    this.onSignedIn,
  });
    final AuthImplementation auth;
    final VoidCallback onSignedIn;
  @override 
  _LoginRegisterState createState()=> _LoginRegisterState();

}
enum FormType{
  login,
  register,
}
class _LoginRegisterState extends State<LoginRegisterPages>
{
  DialogBox dialogBox=new DialogBox();
  final formKey =new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password="";
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
             key: formKey,
                 child:  new Column(
              
                crossAxisAlignment: CrossAxisAlignment.center,
                children: createInputs() + createButton(),
             ),
           ),
         ),
      );
  }
  //methods
  bool valicateAndSave(){
    final form =formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }
  void  validateAndSubmit() async {
    if(valicateAndSave()){
      try{
        if(_formType==FormType.login){
          String userId= await widget.auth.SignIn(_email, _password);
            dialogBox.information(context, "Congratulations","Login....");
          print('Login userId ='+userId);
          widget.onSignedIn();// SignIn successful, return to HomePage
        }else{
          dialogBox.information(context, "Congratulations","Your account has been creater successfully..");
           String userId= await widget.auth.SignUp(_email, _password);
          print('Register userId ='+userId);
          moveToLogin();//  Registration successful, return to the login page

        }
       
      }catch(e){
        dialogBox.information(context, "Error= ", e.toString());
        print("Error= " +e.toString());
      }
    }
  }
  void moveToRegister(){ // Move to SignUp
      formKey.currentState.reset();
      setState(() {
        _formType = FormType.register;
      });
  }
    void moveToLogin(){ //Move to SignIn
      formKey.currentState.reset();
      setState(() {
        _formType = FormType.login;
      });
  }
  
  
  List<Widget> createInputs(){ // Input Email & Password
    return[
      SizedBox(height: 10.0,),
      logo(),
      SizedBox(height: 20.0,),
      new TextFormField(  // UI input email
         validator:(value){
            return value.isEmpty ? 'Email is required.' : null;
         },   
         onSaved:(value){
           return _email = value;
         },
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
      new TextFormField( // UI input password
         validator:(value){
            return value.isEmpty ? 'Password is required.' : null;
         },   
         onSaved:(value){
           return _password = value;
         },
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
  Widget logo() // logo
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
     if(_formType== FormType.login){
        return[
          new  SizedBox(
          width: 200, // specific value
          height: 50,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.lightGreenAccent)
            ),
            child:  new Text("Login", style: new TextStyle(fontSize: 20.0)),
            textColor: Colors.white,
            color: Colors.green[300],
            onPressed: validateAndSubmit ,
          ),
          ),
          new FlatButton(
            child: new Text("Not have an Account? Create Account??", style:  new TextStyle(fontSize:14.0 ),),
            onPressed: moveToRegister,
          ),   
        ];
     }else{
        return[
          new  SizedBox(
            width: 200, // specific value
            height: 50,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.green[900])
              ),
              child:  new Text("Create Account", style: new TextStyle(fontSize: 20.0)),
              textColor: Colors.white,
              color: Colors.green[300],
              onPressed: validateAndSubmit,
            ),
          ),
          new FlatButton(
            child: new Text("Already have a Account?? Login", style:  new TextStyle(fontSize:14.0 ),),
            onPressed: moveToLogin,
          ),    
        ];
      }
   }
}