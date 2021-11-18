


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MooviCowProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 38,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        radius: 36,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          backgroundColor: Colors.grey[900],
          radius: 34,
          child: Image.asset("assets/CuteYellowCow_transparent.png")
        ),
      ),
    );
  }

}