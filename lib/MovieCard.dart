import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:moovi/Movie.dart';
import 'Movie.dart';

class MovieCard extends StatelessWidget {
  //final Movie movie;
  final Movie movie;
  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Swipable(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(movie.movieTitle,
                style: TextStyle(fontSize: 30)),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(20.0)
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Image.network(
                  movie.imageLink,
                  fit: BoxFit.fitHeight
                )
              ),
            )
          ],
        ),
        constraints: BoxConstraints.expand(),
        margin: EdgeInsets.only(top: 40.0),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(16.0)
        )
      ),

      verticalSwipe: false

      //onSwipeLeft: (){},
      //,onSwipeRight: Karley/Lucas's function call goes here
    );
  }
}