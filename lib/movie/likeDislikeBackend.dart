import 'dart:core';
import 'package:moovi/database/DatabaseGetter.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/database/userEntity.dart';
import 'package:moovi/movie/Movie.dart';

var likedMovies = <MovieEntity>[];
var dislikedMovies = <MovieEntity>[];

late MainViewModel mvm;

Future<void> getMvm() async{
    final _database = await DatabaseGetter.instance.database;
    mvm = MainViewModel(_database);
}

void onLikeClicked(UserEntity user, MovieEntity movie) async{
  await getMvm();
  likedMovies.add(movie);
  mvm.addLikedMovieToUser(user, movie);
  mvm.removePersonalQueueMovie(user, movie);
  mvm.updateUserClicks(user, 1);
}

void onDislikeClicked(UserEntity user, MovieEntity movie) async{
  await getMvm();
  dislikedMovies.add(movie);
  mvm.removePersonalQueueMovie(user, movie);
  mvm.updateUserClicks(user, 1);
  // mvm.lowerPersonalQueueMoviePriority(username, movie);
}


