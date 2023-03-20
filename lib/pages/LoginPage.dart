import 'dart:math';
import 'dart:ui';

import 'package:chat_app/Widgets/theme_data.dart';
import 'package:chat_app/Widgets/toast.dart';
import 'package:chat_app/models/UiHelper.dart';
import 'package:chat_app/models/UserModel.dart';
import 'package:chat_app/pages/SignupPage.dart';
import 'package:chat_app/pages/home-page.dart';
import 'package:chat_app/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  State createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  var emailController =TextEditingController();
  var passwordController =TextEditingController();


  void checkValue(String email,String password){
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(email.isEmpty ||password.isEmpty){
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the fields")));
      UiHelper.showAlertDialog(context, "Incomplete Data", "Please fill all the fields");
    }
    
    else{
      logIn(email, password);
    }

  }

  void logIn(String email,String password) async{

    UserCredential? credential;

    UiHelper.showLoadingDialog(context, "Logging in...");

    try{
      credential =await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
    } on FirebaseAuthException catch(error){
      Navigator.pop(context);
      UiHelper.showAlertDialog(context, "An error occured", error.message.toString());
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(error.toString()))
      // );
    }
    print("try is comeplete");

    if(credential!=null){
      print("entering in if condition");
      print("entering in if condition");

      String uid = credential.user!.uid;
      DocumentSnapshot<Map<String, dynamic>> userData = await  FirebaseFirestore.instance.
       collection("users").doc(uid.toString()).get() ;

      UserModel userModel = UserModel.fromMap(userData.data() as Map<String,dynamic>);

      Navigator.popUntil(context, (route) => route.isFirst);
       //go to homepage
      Navigator.pushReplacement(context,
          MaterialPageRoute(
              builder: (context)=> HomePage(userModel: userModel, firebaseUser:credential!.user!)
      ));

    }
    

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Chat App",style: TextStyle(fontSize: 35,color: Colors.green.shade500,fontWeight: FontWeight.w600)),

                  SizedBox(height: 20,),

                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      label: Text("Email"),
                      hintText: "Enter email",
                    ),
                  ),

                  SizedBox(height: 10,),

                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      label: Text("Password"),
                      hintText: "Enter password"
                    ),
                    obscureText: true,
                  ),

                  SizedBox(height:30,),

                  CupertinoButton(
                      onPressed: (){
                        checkValue(emailController.toString(),passwordController.toString());
                      },
                    child: Text("Log In"),
                    color: MyThemeData.darkBluish,
                  ),


                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?",),
            CupertinoButton(
                child:Text("Sign Up") ,
                onPressed: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>SignupPage()
                  ));
                }
            )
          ],
        ),
      ),
    );
  }
}


