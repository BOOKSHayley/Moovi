import 'dart:core';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/database/userEntity.dart';
import '../main.dart';

var likedMovies = <MovieEntity>[];
var dislikedMovies = <MovieEntity>[];
MainViewModel mvm = MyApp.mvm;

void onLikeClicked(UserEntity user, MovieEntity movie) async{
  likedMovies.add(movie);
  mvm.addLikedMovieToUser(user, movie);
  mvm.removePersonalQueueMovie(user, movie);
  mvm.updateUserClicks(user, 1);
}

void onDislikeClicked(UserEntity user, MovieEntity movie) async{
  dislikedMovies.add(movie);
  mvm.removePersonalQueueMovie(user, movie);
  mvm.updateUserClicks(user, 1);
}


