import 'package:chat_app/models/UserModel.dart';
import 'package:chat_app/pages/ChatRoomPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget{

  final UserModel userModel;
  final User firebaseUser;

  SearchPage({required this.userModel,required this.firebaseUser});

  @override
  State<StatefulWidget> createState() => SearchPageState();

}



class SearchPageState extends State<SearchPage>{

  TextEditingController searchController = TextEditingController();
  // // String finalEnterdSearchName = enteredSearchNameController.text.trim();
  // var searchResponse="Enter user name";
  // // Future<List> getUsersUidList
  // // Map<String,dynamic> getUsersUidList = await  FirebaseFirestore.instance.namedQueryGet(name)

  //
  // Future<bool> checkForSearch(String enteredName) async {
  //
  //   CollectionReference collectionReference = FirebaseFirestore.instance.collection("users");
  //   bool enteredNameStatus = false;
  //   QuerySnapshot querySnapshot = await collectionReference.get();
  //   List allData = querySnapshot.docs.map((doc)=> doc.data()).toList();
  //   // print(allData);
  //
  //   for(int a=0;a<allData.length;a++){
  //
  //     String uid;
  //     Map<String,dynamic> getMap =allData[a];
  //     String id = getMap["uid"];
  //
  //     DocumentSnapshot<Map<String,dynamic>> getUserModelMap = await FirebaseFirestore.instance.collection("users").doc(id).get();
  //     UserModel userModel = UserModel.fromMap(getUserModelMap.data() as Map<String, dynamic>);
  //     String checkUserName =userModel.fullName.toString().trim();
  //     print(checkUserName);
  //     print(enteredName);
  //     print('::::::::::::::::::::::::::::::::::::::');
  //     if(checkUserName==enteredName){
  //       enteredNameStatus=true;
  //     }
  //     else{
  //       print("no users founddddddd ************************");
  //     }
  //   }
  //   print(enteredName);
  //   print('?????????????????????????????????????????????????');
  //   return enteredNameStatus;
  // }



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

                // CupertinoButton(child: Text('Search'), onPressed: (){
                //
                // }
                // ),

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
                          where("fullName",isEqualTo: searchController.text.trim()).snapshots(),
                    builder: (context ,snapshot) {

                      if(snapshot.connectionState == ConnectionState.active){
                        if(snapshot.hasData){

                          QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                          if(dataSnapshot.docs.length>0){
                            Map<String,dynamic> userMap = dataSnapshot.docs[0].data() as Map<String,dynamic>;
                            UserModel searchedUserModel = UserModel.fromMap(userMap);

                            return ListTile(
                              onTap: (){
                                Navigator.pop(context);
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>ChatRoomPage(userModel: searchedUserModel)
                                ));
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

    );
  }

}