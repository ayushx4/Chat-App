import 'package:chat_app/Widgets/theme_data.dart';
import 'package:chat_app/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Widgets/chatpage_header.dart';

class ChatRoomPage extends StatefulWidget{

  final UserModel userModel;
  // final User firebaseUser;

  ChatRoomPage({required this.userModel});

  @override
  State<StatefulWidget> createState() => ChatRoomPageState();
}

class ChatRoomPageState extends State<ChatRoomPage>{

  var profilePic="https://cdn.siasat.com/wp-content/uploads/2022/04/akshay_kumar.jpg";
  String profileName="akshay";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.mycolor,

      body: SafeArea(
        child: Column(
          children: [
            ChatPageHeader(widget.userModel.profilePic.toString(),widget.userModel.fullName.toString()),
            SizedBox(
              height: 350,

            ),

            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.yellowAccent,
                child: Column(
                  children: [
                    Positioned(
                      right: 10,
                      child: Container(
                        height: 40,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

}