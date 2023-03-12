import 'dart:developer';

import 'package:chat_app/models/FirebaseHelper.dart';
import 'package:chat_app/models/UserModel.dart';
import 'package:chat_app/pages/LoginPage.dart';
import 'package:chat_app/pages/home-page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser = FirebaseAuth.instance.currentUser;

  log("above if condition&&&&&&&&&&&&&&&&&");


  if(currentUser!=null){
    log("entering first condition)))))))))))))))))))");
    UserModel? thisUserModel = await FirebaseHelper.getUserModelById(currentUser.uid.toString());

    if(thisUserModel!=null){
      log("Entering second condition((((((((((((((((((((");
      runApp(MyAppLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
    }
    else{
      runApp(MyApp());
    }
  }
  else{
    runApp(MyApp());
  }
  }


//user not logged in
class MyApp extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    log("enterd in My App..................................");
    return MaterialApp(
      title: "Chat App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: LoginPage(),
      // home: HomePage(),
    );
  }
}

// user already logged in
class MyAppLoggedIn extends StatelessWidget{

  final UserModel userModel;
  final User firebaseUser;

  MyAppLoggedIn({required this.userModel, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: HomePage(userModel: userModel, firebaseUser: firebaseUser),
      // home: HomePage(),
    );
  }

}


