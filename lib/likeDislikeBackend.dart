import 'dart:core';
import 'package:moovi/Movie.dart';

var likedMovies = <Movie>[];
var dislikedMovies = <Movie>[];

void onLikeClicked(Movie movie){
  likedMovies.add(movie);
  //todo: remove movie from Chris's queue

}

void onDislikeClicked(Movie movie){
  dislikedMovies.add(movie);
  //todo: remove movie and add back to the end of Chris's queue
}