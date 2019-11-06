import 'package:flutter/material.dart';
import 'Mapping.dart';
import 'Authentication.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,//remove banner of debug flutter
      title: 'Welcome to Flutter',
      home: new MappingPage(auth: Auth(),) ,
      
    );
  }
}