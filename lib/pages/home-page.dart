import 'package:chat_app/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/theme_data.dart';

class HomePage extends StatefulWidget{
  final  UserModel userModel;
  final User firebaseUser;

  const HomePage({super.key, required this.userModel, required this.firebaseUser});
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  String profileName="akshay";
  var profilePic="https://cdn.siasat.com/wp-content/uploads/2022/04/akshay_kumar.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.creamColor,

      appBar: AppBar(
        title: Text("Chat app"),
      ),
      body: SafeArea(
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context,"\chatPage" );
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(profilePic),
            ),
            title: Text(profileName),
          ),
        ),
      ),
    );
  }

}