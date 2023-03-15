import 'package:chat_app/models/UserModel.dart';
import 'package:chat_app/pages/SearchPage.dart';
import 'package:chat_app/pages/SignupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
        // centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
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

            CupertinoButton(
                child: Text("signin page"),
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context)=>SignupPage(),
                    ));
                }
                ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context)=> SearchPage(userModel: widget.userModel, firebaseUser: widget.firebaseUser))
          );
        },
      ),
    );
  }

}