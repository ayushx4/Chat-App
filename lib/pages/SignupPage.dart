import 'package:chat_app/models/UserModel.dart';
import 'package:chat_app/pages/CompleteProfile.dart';
import 'package:chat_app/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Widgets/theme_data.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var cPasswordController = TextEditingController();

//comment
  void cheakValues(){
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if(email.isEmpty || password.isEmpty || cPassword.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all the fields!"))
      );
    }
    else if(password!=cPassword){
      print('Password do not match');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password do not match"))
      );
    }
    else{
      print('Sign up succesfully');
      signUp(email, password);
    }

  }

  void signUp(String email,String paassword) async{
    UserCredential? credential;

    try{
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: paassword);
    } on FirebaseAuthException catch(error){
      print(error.message.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message.toString()))
      );
    }


    if(credential != null){
      String uid = credential.user!.uid;
      UserModel newUser = UserModel(
        uid: uid,
        email: email,
        fullName: "",
        profilePic: "",

      );
      await FirebaseFirestore.instance.collection("users").doc(uid).set(newUser.toMap()).then((value){
        print('new user created');
        // Navigator.pushReplacementNamed(context, MyRoutes.completeProfile);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context)=> CompleteProfile(userModel: newUser, firebaseUser: credential!.user!)
            ));

      });
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

                  TextField(
                    controller: cPasswordController,
                    decoration: InputDecoration(
                        label: Text("Confirm password"),
                        hintText: "Enter confirm password"
                    ),
                    obscureText: true,
                  ),

                  SizedBox(height:30,),

                  CupertinoButton(
                    child: Text("Sign Up"),
                    onPressed: (){
                      cheakValues();
                      // Navigator.pushNamed(context, MyRoutes.completeProfile);
                    },
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
            Text("Alredy have account",),
            CupertinoButton(
                child:Text("Log In") ,
                onPressed: (){
                  Navigator.pop(context); //pop means remove this page and go backward
                }
            )
          ],
        ),
      ),
    );
  }
}
