import 'dart:developer';

import 'package:chat_app/Widgets/theme_data.dart';
import 'package:chat_app/models/FirebaseHelper.dart';
import 'package:chat_app/models/UserModel.dart';
import 'package:chat_app/pages/LoginPage.dart';
import 'package:chat_app/pages/home-page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser = FirebaseAuth.instance.currentUser;

  log("above if condition&&&&&&&&&&&&&&&&&");

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

    statusBarColor: Colors.transparent,
  ));

  if (currentUser != null) {
    log("entering first condition)))))))))))))))))))");
    UserModel? thisUserModel = await FirebaseHelper.getUserModelById(
        currentUser.uid.toString());



    if (thisUserModel != null) {
      log("Entering second condition((((((((((((((((((((");
      runApp(
          MyAppLoggedIn(firebaseUser: currentUser, userModel: thisUserModel));
    }
    else {
      runApp(MyApp());
    }
  }
  else {
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
          appBarTheme: AppBarTheme(
              // color: CupertinoColors.systemGreen
            color: Colors.teal[600]
          )


      ),
      home: LoginPage(),
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
          appBarTheme: AppBarTheme(
              // color: CupertinoColors.systemGreen
              color: Colors.teal[600]

          )

      ),
      home: HomePage(userModel: userModel, firebaseUser: firebaseUser),
    );
  }

}


