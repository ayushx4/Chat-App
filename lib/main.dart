import 'package:chat_app/pages/CompleteProfile.dart';
import 'package:chat_app/pages/LoginPage.dart';
import 'package:chat_app/pages/SignupPage.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/home-page.dart';
import 'package:chat_app/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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

