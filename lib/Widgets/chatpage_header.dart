import 'package:chat_app/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

ChatPageHeader(String profilePic,String profileName,UserModel userModel,User firebaseUser){
  return Container(
    width: double.infinity,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
      color: Colors.green.shade50,
    ),
    child: Column(
      children: [
        SizedBox(height: 30,),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back),
                onPressed: (){
                    // Navigator.pushReplacement(context as BuildContext,
                    //     MaterialPageRoute(
                    //         builder: (context)=> HomePage(userModel: userModel, firebaseUser: firebaseUser)
                    //     ));
                },
              ),

              //Profile pic
              CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(profilePic),
              ),

              //profile name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(profileName),
              )

            ],
          ),
        ),
      ],
    ),
  );
}