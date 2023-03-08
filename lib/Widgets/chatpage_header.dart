import 'package:flutter/material.dart';

ChatPageHeader(String profilePic,String profileName){
  return Container(
    width: double.infinity,
    height: 65,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
      color: Colors.green.shade50,
    ),
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          //Profile pic
          CircleAvatar(
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
  );
}