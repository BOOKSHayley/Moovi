


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RandoUserProfilePic extends StatelessWidget {

  String pic;

  RandoUserProfilePic(this.pic);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 38,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        radius: 36,
        backgroundColor: Colors.white,
        child: CircleAvatar(
            // backgroundColor: const Color(0xff14171a),
            radius: 34,
            backgroundImage: AssetImage(pic)// Image.asset(pic),
            // child:
        ),
      ),
    );
  }

}