import 'dart:developer';
import 'package:chat_app/Widgets/theme_data.dart';
import 'package:chat_app/models/MassegeModel.dart';
import 'package:chat_app/models/UserModel.dart';
import 'package:chat_app/pages/ImageSentPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uuid/uuid.dart';
import '../Widgets/chatpage_header.dart';
import '../models/ChatRoomModel.dart';

class ChatRoomPage extends StatefulWidget{

  final UserModel targetUserModel;
  final ChatRoomModel chatRoomModel;
  final UserModel userModel;
  final User firebaseUser;

  ChatRoomPage({required this.targetUserModel, required this.userModel, required this.firebaseUser, required this.chatRoomModel});

  @override
  State<StatefulWidget> createState() => ChatRoomPageState();
}

class ChatRoomPageState extends State<ChatRoomPage>{
  var messageController = TextEditingController();
  var profilePic="https://cdn.siasat.com/wp-content/uploads/2022/04/akshay_kumar.jpg";

  void sendMessage() async{
    String message = messageController.text;
    messageController.clear();

    if(message.isNotEmpty){


      //sent message
      MessageModel newMessage = MessageModel(
        text: message,
        messageId: Uuid().v1(),
        sender: widget.userModel.uid,
        createdon: DateTime.now(),
        seen: false
      );
      FirebaseFirestore.instance.collection("chatrooms").doc
        (widget.chatRoomModel.chatRoomId).collection("messages").doc(newMessage.messageId).set(newMessage.toMap());
      //Here we not use await because Firebase also give offline storage and when user goes online automatic update in firebase
      //when we use await it wait for this and massage not shown in white space while backend work is not done.\
      widget.chatRoomModel.lastMessage = message;
      widget.chatRoomModel.createdonChatroomModel = DateTime.now();
      widget.chatRoomModel.usersList=[widget.userModel.uid.toString(),
                                      widget.targetUserModel.uid.toString()];
      FirebaseFirestore.instance.collection("chatrooms").doc(widget.chatRoomModel.chatRoomId).set(widget.chatRoomModel.toMap());
      log("Message sent!");

    }
    else{
      //eat fiveStart do nothing
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.mycolor,

      body: SafeArea(
        child: Column(
          children: [
            ChatPageHeader(widget.targetUserModel.profilePic.toString(),widget.targetUserModel.fullName.toString()),

            Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: StreamBuilder(

                      stream: FirebaseFirestore.instance.collection
                        ("chatrooms").doc(widget.chatRoomModel.chatRoomId).collection
                        ("messages").orderBy("createdon",descending: true).snapshots(),
                    // here we use order by because using createdom which have dateTime
                    // we fetch data in descending order so our last chat shows to bottom area using listview builder

                    builder: (context,snapshot){

                        if(snapshot.connectionState == ConnectionState.active){
                          if(snapshot.hasData){
                            QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                            return NotificationListener<OverscrollIndicatorNotification>(
                              onNotification: (overScroll){
                                overScroll.disallowGlow();
                                return true;
                              },
                                child: ListView.builder(
                              reverse: true,  //so chats starts from bottom
                              itemCount: dataSnapshot.docs.length,
                              itemBuilder: (context,index){
                                MessageModel currentMessage = MessageModel.fromMap
                                  (dataSnapshot.docs[index].data() as Map<String,dynamic>);

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 1),
                                  child: Row(
                                    mainAxisAlignment: (currentMessage.sender == widget.userModel.uid) ?
                                    MainAxisAlignment.end : MainAxisAlignment.start ,
                                    children: [
                                      SizedBox(
                                        width : 350,
                                        child: Container(
                                            padding: EdgeInsets.all(9),
                                            margin: EdgeInsets.symmetric(horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: (
                                                    currentMessage.sender == widget.userModel.uid) ?
                                                MyThemeData.creamColor : Colors.white,
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(Radius.circular(14)),

                                            ),
                                            child: Text(currentMessage.text.toString(),
                                              style: TextStyle(color: Colors.deepPurple,fontSize: 18),)),
                                      ),
                                    ],
                                  ),
                                )
                                ;
                              },
                            )
                            );
                                
                          }
                          else if(snapshot.hasError){
                            return Center(
                              child: Text("An error occurred! Please check your internet connection."),
                            );
                          }
                          else{
                            // chatroom not created
                            return Center(
                              child: Text("Say hi to your new friend"),
                            );
                          }
                        }
                        else{
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                    },

                  ),
                ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              height: 50 ,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
                children: [
                  Flexible(
                      child:TextField(
                        controller: messageController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Message",
                          border: InputBorder.none,
                        ),
                      )
                  ),

                  IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>ImageSentpage(
                                userModel: widget.userModel,
                                firebaseUser: widget.firebaseUser,
                                targetUserModel: widget.targetUserModel)));
                      },
                      icon: Icon(Icons.camera_alt)
                  ),

                  IconButton(onPressed: (){
                    sendMessage();
                    setState(() {

                    });
                  },
                    icon: Image.asset("assets/images/sent.png",color: Colors.green),
                  )
                ],
              ),
            ),

            SizedBox(height: 6,)

          ],
        ),
      ),
    );
  }
}
