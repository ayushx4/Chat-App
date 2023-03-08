import 'package:chat_app/Widgets/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

toast(String meassage){
  Toast.show(
    meassage,
    gravity: Toast.bottom,
      backgroundColor: Colors.yellow,
    duration: 4,
    textStyle: TextStyle(color: Colors.redAccent),
  );
}