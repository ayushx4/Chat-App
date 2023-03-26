import 'dart:developer';

import 'package:chat_app/models/ChatRoomModel.dart';
import 'package:chat_app/models/FirebaseHelper.dart';
import 'package:chat_app/models/UserModel.dart';
import 'package:chat_app/pages/ChatRoomPage.dart';
import 'package:chat_app/pages/LoginPage.dart';
import 'package:chat_app/pages/profilePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../Widgets/theme_data.dart';
import 'SearchPage.dart';

class HomePage extends StatefulWidget{
  final  UserModel userModel;
  final User firebaseUser;

  const HomePage({super.key, required this.userModel, required this.firebaseUser});
  @override
  State<StatefulWidget> createState() => HomePageState();
}


enum MenuValues{
  profile,
  signOut,
}


class HomePageState extends State<HomePage>{

  String profileName="akshay";
  var profilePic="https://cdn.siasat.com/wp-content/uploads/2022/04/akshay_kumar.jpg";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: MyThemeData.creamColor,
      appBar: AppBar(

        elevation: 0,
        centerTitle: false,

        title: Text("Chat app",style: TextStyle(color: Colors.white),),
        // leading: PopupMenuButton<MenuValues>(
        //   icon: Icon(Icons.menu),
        //   itemBuilder: (BuildContext context)=> [
        //   PopupMenuItem(child : Text("Profile"),value: MenuValues.profile,),
        //   PopupMenuItem(child: Text("Sign out"), value: MenuValues.signOut,),
        // ],
        //   onSelected: (value)async{
        //     switch(value){
        //       case MenuValues.profile :
        //         Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage(userModel: widget.userModel, firebaseUser: widget.firebaseUser)));
        //         break;
        //
        //       case MenuValues.signOut :
        //         await FirebaseAuth.instance.signOut();
        //         Navigator.popUntil(context, (route) => route.isFirst);
        //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
        //         break;
        //
        //     }
        //   },
        // )
        // actions: [
        //   IconButton(
        //       onPressed: (){
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context)=> SearchPage (userModel: widget.userModel, firebaseUser: widget.firebaseUser)
        //         ));
        //       },
        //       icon: Icon(Icons.search_rounded),
        //   ),
        // ],

        // centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("chatrooms").where
              ("usersList",arrayContains: widget.userModel.uid).orderBy("createdonChatroomModel",descending: true).snapshots(),
            builder:(context,snapshot){

              if(snapshot.connectionState== ConnectionState.active){

                log("Connection state is active true >>>>>>>>>>>>>>>");
                if(snapshot.hasData){

                  log("snapshot has date true_________________________");
                  QuerySnapshot chatRoomSnapshot = snapshot.data as QuerySnapshot;

                  return NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll){
                      overScroll.disallowGlow();
                      return true;
                    },
                    child: ListView.builder(
                        itemCount: chatRoomSnapshot.docs.length,
                        itemBuilder:(context,index){
                          ChatRoomModel chatRoomModel = ChatRoomModel.fromMap
                            (chatRoomSnapshot.docs[index].data() as Map<String,dynamic>);

                          // FirebaseFirestore.instance.

                          Map<String,dynamic> participants = chatRoomModel.participants as Map<String,dynamic>;
                          List<String> participantskeys = participants.keys.toList();
                          participantskeys.remove(widget.userModel.uid);

                          log("entering in futureBuilder++++++++++++++++++++++++++++");
                          return FutureBuilder(

                              future: FirebaseHelper.getUserModelById(participantskeys[0]),
                              builder: (context,userData){


                                if(userData.connectionState == ConnectionState.done){
                                  if(userData.data != null){
                                    UserModel targetUserModel = userData.data as UserModel;
                                    log("future builder active state is true ****************************");
                                    return  ListTile(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(

                                                builder: (context)=> ChatRoomPage(
                                                    targetUserModel: targetUserModel,
                                                    userModel: widget.userModel,
                                                    firebaseUser: widget.firebaseUser,
                                                    chatRoomModel: chatRoomModel
                                                )
                                            ));
                                      },
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        backgroundImage: NetworkImage(targetUserModel.profilePic.toString()),
                                      ),
                                      title: Text(targetUserModel.fullName.toString()),
                                      subtitle: (chatRoomModel.lastMessage!.isEmpty) ?
                                      Text("Say hello to your new friend",style:TextStyle(color: Colors.blue),) :
                                      Container(
                                        width: 10,
                                        child : Text(chatRoomModel.lastMessage.toString(),overflow: TextOverflow.ellipsis,),),
                                      // trailing: Text(messageModel.createdon.toString()),
                                    );
                                  }
                                  else{
                                    return Container();
                                  }
                                }
                                else{
                                  return Container();
                                }
                              }
                          );

                        }
                    ),
                  );

                }
                else if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                else{
                  return Text("No Chats");
                }
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
        ),
      )
      ,


      bottomNavigationBar: Container(
        color: Colors.teal.shade700,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),
          child: GNav(
            gap: 15,

            color: Colors.black,
            backgroundColor: Colors.teal.shade700,
            tabBackgroundColor: Colors.white24,
            padding: EdgeInsets.all(10),
            selectedIndex: 0,
            tabs: [
              GButton(icon: Icons.home_filled,
              text: "Home",),
              GButton(icon: Icons.search_rounded,
              text: "Search",
              onPressed: (){
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context)=> SearchPage (userModel: widget.userModel, firebaseUser: widget.firebaseUser)
                    ));
              },),
              GButton(icon: FontAwesomeIcons.circleHalfStroke),
              GButton(icon: Icons.person,
              text: "Profile",),
            ],
          ),
        ),
      ),


    );
  }

}