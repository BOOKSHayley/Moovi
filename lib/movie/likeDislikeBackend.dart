import 'dart:core';
import 'package:moovi/database/DatabaseGetter.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/movie/Movie.dart';

var likedMovies = <MovieEntity>[];
var dislikedMovies = <MovieEntity>[];

late MainViewModel mvm;

Future<void> getMvm() async{
    final _database = await DatabaseGetter.instance.database;
    mvm = MainViewModel(_database);
}

void onLikeClicked(String username, MovieEntity movie) async{
  await getMvm();
  likedMovies.add(movie);
  mvm.addLikedMovieToUser(username, movie);
  mvm.removePersonalQueueMovie(username, movie);
}

void onDislikeClicked(String username, MovieEntity movie) async{
  await getMvm();
  dislikedMovies.add(movie);
  mvm.removePersonalQueueMovie(username, movie);
  // mvm.lowerPersonalQueueMoviePriority(username, movie);
}


