

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MooviProgressIndicator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          child: CircularProgressIndicator(color: Colors.yellow,),
          height: 100,
          width: 100,
        ),
        SizedBox(
          child:Image.asset("assets/CuteYellowCow_transparent.png"),
          height: 98,
          width: 98,
        )
      ],
    ));
  }

}