import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:moovi/database/movieEntity.dart';
import '../main.dart';
import 'likeDislikeBackend.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:math';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;
  final username;
  final StreamController<double> _controller = StreamController<double>();
  MovieCard(this.username, this.movie);
  //final MovieEntity m; **********************************************************
  //MovieCard(this.m); ************************************************************

  @override
  Widget build(BuildContext context) {
    return Swipable(
      child: FlipCard(
        fill: Fill.fillBack,
        direction: FlipDirection.HORIZONTAL,
        front: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  movie.title,
                        //m.title, ******************************************************
                  style: TextStyle(fontSize: 30)
                ),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(20.0)
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Container(
                    child: Image.network(
                      movie.imageUrl,
                      //m.imageUrl, **************************************************
                      fit: BoxFit.fitHeight
                    ),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0))
                  )
                ),
              )
            ],
          ),
          constraints: BoxConstraints.expand(),
          margin: EdgeInsets.only(top: 40.0),
          decoration: BoxDecoration(
            color: Colors.indigo[300],
            borderRadius: BorderRadius.circular(16.0)
          )
        ),
        back: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  )
                )
              ),
              Text(
                movie.year.toString(),
                style: TextStyle(fontSize: 18)
              ),

              Padding(padding: EdgeInsets.only(left: 20, right: 20), child: Divider(color: Colors.white)),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Rated " + movie.mpaa + " | " + movie.runtime,
                  style: TextStyle(fontSize: 25)
                )
              ),
              Padding(padding: EdgeInsets.only(top: 10, left: 20, right: 20), child: Text("IMDB Rating: " + movie.imdb.toString() + "/10", style: TextStyle(fontSize: 25))),

              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(
                  movie.genres,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25)
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(movie.synopsis,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25)
                )
              ),
              Padding(padding: EdgeInsets.only(top: 10, left: 20, right: 20), child: Text(
                  "Available on: " + movie.streamingService,
                  style: TextStyle(fontSize: 25)
              ))
            ],
          ),
          constraints: BoxConstraints.expand(),
          margin: EdgeInsets.only(top: 40.0),
          decoration: BoxDecoration(
            color: Colors.indigo[300],
            borderRadius: BorderRadius.circular(16.0)
          )
        )
      ),
      verticalSwipe: false,

      onSwipeLeft: (position){onDislikeClicked(MyApp.user, movie);},
      onSwipeRight: (position){onLikeClicked(MyApp.user, movie);},
      swipe: _controller.stream,

      //onSwipeLeft: (position){onDislikeClicked(m);}, *********************************
    );
  }

  autoSwipe(bool leftSwipe){
    double swipeAngle;
    if (leftSwipe)
      swipeAngle = pi;
    else
      swipeAngle = 0;
    _controller.add(swipeAngle);
  }
}