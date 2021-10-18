import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:moovi/Movie.dart';
import 'Movie.dart';

class MovieCard extends StatelessWidget {
  //take a movie as a field?
  final String title;
  final String imgurl;
  MovieCard(this.title, this.imgurl);

  @override
  Widget build(BuildContext context) {
    return Swipable(
      //format this
        child: Container(
            child: Column(
              children: <Widget>[
                Text(title),
                Image.network(imgurl)
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(16.0)
            )
        )
      //,onSwipeLeft: Karley/Lucas's function call goes here
      //,onSwipeRight: Karley/Lucas's function call goes here
    );
  }
}