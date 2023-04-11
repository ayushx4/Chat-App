import 'dart:math';

import 'package:flutter/material.dart';

class FlipCoin extends StatefulWidget {
  const FlipCoin({Key? key}) : super(key: key);

  @override
  State<FlipCoin> createState() => _FlipCoinState();
}

class _FlipCoinState extends State<FlipCoin> {

  var randomNum = Random().nextInt(2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Text("Flip Coin"),

            Container(
            )


          ],
        ),
      ),
    );
  }
}
