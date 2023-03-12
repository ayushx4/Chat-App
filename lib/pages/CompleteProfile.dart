import 'dart:developer';
import 'dart:io';

import 'package:chat_app/Widgets/theme_data.dart';
import 'package:chat_app/models/UserModel.dart';
import 'package:chat_app/pages/home-page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class CompleteProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const CompleteProfile({super.key, required this.userModel, required this.firebaseUser});


  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {

  CroppedFile? imageFile;

  var fullNameController = TextEditingController();



  void selectImage(ImageSource source) async{
   XFile? pickedFile = await ImagePicker().pickImage(source: source);

   if(pickedFile != null){
     cropImage(pickedFile);
   }
  }

  void cropImage(XFile file) async{

    // File file2= File(file.path);

    CroppedFile? croppedImage =await ImageCropper().cropImage(
        sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      // compressQuality: 20,
    );


    if(croppedImage!=null){
      setState(() {
        imageFile = croppedImage;
      });

      print(imageFile as String);
      print("____________---______-----____________----********************");

    }
  }


  void showPhotoOptions() {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Upload profile picture"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: (){
                Navigator.pop(context);
                selectImage(ImageSource.gallery);
              },
              leading: Icon(Icons.photo),
              title: Text("Select from Gallery"),
            ),

            ListTile(
              onTap: (){
                Navigator.pop(context);
                selectImage(ImageSource.camera);
              },
              leading: Icon(Icons.camera_alt),
              title: Text("Take a photo"),
            ),

          ],
        ),

      );
    });
  }


  void checkValues(){
    print('Entering check valute function');

    String fullName = fullNameController.text.trim();

    log(fullName+"_________________________________________________");

    if(fullName.isEmpty || imageFile=="") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text("Please fill all the fields"))
      );
    }
    else{
      uploadData();
    }

  }

  void uploadData() async{

    //We use UploadTask for get image url and we add this url into firebase .
    log("Uploading Data........");
    log("Uploading Data........");
    log("Uploading Data........");
    log("Uploading Data........");

    UploadTask uploadTask = FirebaseStorage.instance.ref("profilepicture").
    child(widget.userModel.uid.toString()).putFile(File(imageFile!.path));

    log(">>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<");
    print('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>');

    TaskSnapshot snapshot =await uploadTask.snapshot;

    log("Data Up to date %%%%%%%%%%%%%**********#########################");
    log("Data Up to date %%%%%%%%%%%%%**********#########################");
    log("Data Up to date %%%%%%%%%%%%%**********#########################");


    String imageUrl = await snapshot.ref.getDownloadURL().toString();
    String fullName = fullNameController.text.trim();

    log(imageUrl.toString());
    log(imageUrl.toString());
    log(imageUrl.toString());

    log("image uuuurl&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    log("image uuuurl&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    log("image uuuurl&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");

    widget.userModel.fullName = fullName;
    widget.userModel.profilePic =  imageUrl;

    await FirebaseFirestore.instance.collection("users").doc(widget.userModel.uid).set(widget.userModel.toMap());
    print('Data uploaded');
    print('Data uploaded');
    print('Data uploaded');

    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=> HomePage(userModel: widget.userModel, firebaseUser: widget.firebaseUser)
        ));

  }












  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Complete Profile"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [

               SizedBox(height: 35,),

              CupertinoButton(
                child:
                CircleAvatar(
                  radius: 70,
                  backgroundImage: (imageFile != null) ? FileImage(File(imageFile!.path)):null,
                  child: (imageFile == null) ? Icon(Icons.person,size: 55,) : null,
                ),


                onPressed: (){
                  showPhotoOptions();
                },
              ),

              SizedBox(height: 35,),

              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  label: Text("Name"),
                  hintText: "Enter name",
                ),
              ),

              SizedBox(height: 20,),

              CupertinoButton(
                color: MyThemeData.darkBluish,
                  child: Text("Submit") , onPressed: (){
                print('button press______________-------------_________');
                    checkValues();
              })


            ],
          ),
        ),
      ),
    );
  }
}
