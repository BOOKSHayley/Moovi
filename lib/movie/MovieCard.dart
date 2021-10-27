import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/movie/Movie.dart';
import 'Movie.dart';
import 'likeDislikeBackend.dart';
import 'package:flip_card/flip_card.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  MovieCard(this.movie);
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
                  movie.movieTitle,
                  //m.title, ******************************************************
                  style: TextStyle(fontSize: 30)
                ),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(20.0)
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Image.network(
                    movie.imageLink,
                    //m.imageUrl, **************************************************
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
        back: Container(
          child: Column(
            children: [
              Text(movie.movieTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold )
              ),
              Text(movie.MPAA_Rating,
                  style: TextStyle(fontSize: 25)
              ),
              Text(movie.movieGenre,
                  style: TextStyle(fontSize: 25)
              ),
              Text(movie.movieRuntime,
                  style: TextStyle(fontSize: 25)
              ),
              Text(movie.movieSynopsis,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25)
              ),
            ],
            //Lucas! All of your layout for information displayed on the back of the card will be children of this Column widget!
            //Please do not touch the other properties of the Container widget assigned to the back parameter. The app will go nuts.
          ),
          constraints: BoxConstraints.expand(),
          margin: EdgeInsets.only(top: 40.0),
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(16.0)
          )
        )
      ),
      verticalSwipe: false,
      onSwipeLeft: (position){onDislikeClicked(movie);},
      onSwipeRight: (position){onLikeClicked(movie);},
      //onSwipeLeft: (position){onDislikeClicked(m);}, *********************************
    );
  }
}