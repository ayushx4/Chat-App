import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/UserModel.dart';



class ImageSentpage extends StatefulWidget{

  final UserModel targetUserModel;
  final UserModel userModel;
  final User firebaseUser;



  ImageSentpage({required this.userModel, required this.firebaseUser , required this.targetUserModel});
  @override
  State<StatefulWidget> createState() => ImageSentPageState();

}

class ImageSentPageState extends State<ImageSentpage>{

  // Map<String,dynamic> participants = widget.chatRoomModel.participants as Map<String,dynamic>;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
        ),

        //top
        Positioned(
          top: 50,
            child:Container(
              height: 100,
              width: 100,
              child: Row(
                children: [
                  Icon(Icons.close),
                  SizedBox(width: 340,),
                  Icon(Icons.edit),
                ],
              ),
            ),
        ),

        //bottom
        Positioned(
          bottom: 100,
            right: 10,
            left: 10,
            child: Container(
              height: 50,

              child: Row(
                children: [
                  Container(
                    height : 30,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: Text(widget.targetUserModel.fullName.toString()),
                  ),
                  IconButton(onPressed: (){}, icon: Image.asset("assets/images/sent.png"))
                ],
              ),
            )
        ),
        
      ],
    );
  }

}