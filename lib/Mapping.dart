import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginRegisterPage.dart';
import 'HomePage.dart';
import 'Authentication.dart';
class MappingPage extends StatefulWidget{
  final AuthImplementation auth;
  MappingPage({
    this.auth,
  });
 
  State<StatefulWidget> createState(){
    return _MappingPageState();
  }
}
enum AuthStatus{
  notSignedIn,
  singedIn,
}
class _MappingPageState extends State <MappingPage>
{
  AuthStatus authStatus = AuthStatus.notSignedIn;
  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((firebaseUserId){
      setState(() {
       authStatus = firebaseUserId ==null? AuthStatus.notSignedIn: AuthStatus.singedIn; 
      });
    });
  }
  void _singedIn(){
    setState(() {
     authStatus =AuthStatus.singedIn; 
    });
  }
   void _singOut(){
    setState(() {
     authStatus =AuthStatus.notSignedIn; 
    });
  }
  @override 
  Widget build (BuildContext context){
    switch(authStatus)
    {
      case AuthStatus.notSignedIn:
      return new LoginRegisterPages(
        auth: widget.auth,
        onSignedIn: _singedIn,
      );    
      case AuthStatus.singedIn:
       return new HomePage(
        auth: widget.auth,
        onSignedOut: _singOut,);
    }
    return null;
  }
}