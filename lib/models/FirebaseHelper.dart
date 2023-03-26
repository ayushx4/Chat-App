import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'UserModel.dart';

class FirebaseHelper {

  static Future<UserModel?> getUserModelById(String uid) async{
    UserModel? userModel;
    DocumentSnapshot documentSnapshot =await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if(documentSnapshot != null){
      log("we are in if condition============");
      log(documentSnapshot.toString());
      userModel = UserModel.fromMap(documentSnapshot.data() as Map<String,dynamic>);
  }

    return userModel;
  }

}