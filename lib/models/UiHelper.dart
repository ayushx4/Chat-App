import 'package:flutter/material.dart';

class UiHelper{

  static void showLoadingDialog(BuildContext context , String title){
    AlertDialog loadingDialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
        SizedBox(height: 8,),
        Text(title),
        ],
      ),
    );
    
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context){
      return loadingDialog;
    });
  }


  static void showAlertDialog (BuildContext context , String title , String content){
    AlertDialog alertDialog= AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
        onPressed: (){
          Navigator.pop(context);
        },
         child: Text("ok")),

      ],
    );

    showDialog(
        context: context,
        builder: (context){
      return alertDialog;
    });

  }

}