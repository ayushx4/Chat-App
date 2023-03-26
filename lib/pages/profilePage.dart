import 'package:chat_app/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {

  final UserModel userModel;
  final User firebaseUser;
  ProfilePage({ required this.userModel,required this.firebaseUser});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //profilepic
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25,),
                    Center(
                      child: Container(
                        child: CircleAvatar(
                          backgroundColor: CupertinoColors.darkBackgroundGray,
                          backgroundImage: NetworkImage(widget.userModel.profilePic.toString()),
                          radius: 80,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(widget.userModel.fullName.toString(),style: TextStyle(color: Colors.red),),
                    Card(
                      // child: ,
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      )    );
  }
}
