import 'dart:math';

import 'package:chat_app/models/UserModel.dart';
import 'package:chat_app/pages/ChatRoomPage.dart';
import 'package:chat_app/pages/home-page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uuid/uuid.dart';
import '../models/ChatRoomModel.dart';


class SearchPage extends StatefulWidget{

  final UserModel userModel;
  final User firebaseUser;

  SearchPage({required this.userModel,required this.firebaseUser});

  @override
  State<StatefulWidget> createState() => SearchPageState();

}



class SearchPageState extends State<SearchPage>{

  TextEditingController searchController = TextEditingController();


  Future<ChatRoomModel?> getChatroomModel(UserModel targetUserModel) async {

    ChatRoomModel? chatroomModel;

    QuerySnapshot snapshot=await FirebaseFirestore.instance.collection("chatrooms").where
      ("participants.${widget.userModel.uid}", isEqualTo: true).where
      ("participants.${targetUserModel.uid}", isEqualTo: true).get();

    if(snapshot.docs.length>0){
      // Fetch the existing one
      print('Chat room already created!');

      var docData = snapshot.docs[0].data();

      ChatRoomModel existingChatRoomModel = ChatRoomModel.fromMap(docData as Map<String,dynamic>);

      chatroomModel= existingChatRoomModel;
    }
    else{
      //Create chatRoomModel
      print('ChatRoom not created?');
      ChatRoomModel newChatRoomModel= ChatRoomModel(
        chatRoomId: Uuid().v1(),  //here we use Uuid package for generate uid
          lastMessage: "",
        createdonChatroomModel: DateTime.now(),
        participants:{
          widget.userModel.uid.toString() : true,
          targetUserModel.uid.toString() : true,
        },
        usersList: [widget.userModel.uid.toString() ,
                    targetUserModel.uid.toString()]
      );

      await FirebaseFirestore.instance.collection("chatrooms").doc(
         newChatRoomModel.chatRoomId).set(newChatRoomModel.toMap());

      chatroomModel = newChatRoomModel;

      print('New chatroom created');
    }

    return chatroomModel;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        // automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    label: Text("Search"),
                  ),
                ),

                SizedBox(height: 20,),

                ActionChip
                  (onPressed: (){
                    setState(() {

                    });
                },
                    disabledColor: Colors.yellowAccent,
                    label: Text("Search")
                ),

                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users").
                          where("fullName",
                      isEqualTo: searchController.text.trim(),
                      isNotEqualTo: widget.userModel.fullName).snapshots(),

                    builder: (context ,snapshot) {

                      if(snapshot.connectionState == ConnectionState.active){
                        if(snapshot.hasData){

                          QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                          if(dataSnapshot.docs.length>0){
                            Map<String,dynamic> userMap = dataSnapshot.docs[0].data() as Map<String,dynamic>;
                            UserModel searchedUserModel = UserModel.fromMap(userMap);

                            return ListTile(
                              onTap: () async{

                               ChatRoomModel? chatroomModel = await getChatroomModel(searchedUserModel);

                               if(chatroomModel != null){
                                 Navigator.popUntil(context, (route) => route.isFirst);
                                 Navigator.push(context,
                                     MaterialPageRoute(builder: (context)=>ChatRoomPage(
                                       targetUserModel: searchedUserModel,
                                       userModel: widget.userModel,
                                       firebaseUser: widget.firebaseUser,
                                       chatRoomModel: chatroomModel,
                                     )
                                     ));
                               }
                              },
                              title: Text(searchedUserModel.fullName!),
                              subtitle: Text(searchedUserModel.email!),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(searchedUserModel.profilePic!),
                              ),
                            );
                          }
                          else {
                            return Text("no results found");
                          }

                        }
                        else if(snapshot.hasError){
                          return Text("An error accured!");
                        }
                        else{
                          return Text("no results found! ");
                        }
                      }
                      else{
                        return CircularProgressIndicator();
                      }
                    }

                ),


              ],
            ),
          ),
        ),
      ),


      bottomNavigationBar: Container(
        color: Colors.teal.shade700,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),
          child: GNav(
            gap: 15,
            haptic: true,
            color: Colors.black,
            backgroundColor: Colors.teal.shade700,
            tabBackgroundColor: Colors.white24,
            padding: EdgeInsets.all(10),
            selectedIndex: 1,
            tabs: [
              GButton(icon: Icons.home_filled,
                text: "Home",
                onPressed: (){
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(userModel: widget.userModel, firebaseUser: widget.firebaseUser)));
                },
              ),
              GButton(icon: Icons.search_rounded,
                text: "Search",),
              GButton(icon: FontAwesomeIcons.circleHalfStroke,
              text: "HOT",),
              GButton(icon: Icons.person,
                text: "Profile",),
            ],
          ),
        ),
      ),

    );
  }

}