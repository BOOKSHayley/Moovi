

import 'package:moovi/database/friends_dao.dart';
import 'package:moovi/database/likedMovie_dao.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/database/movie_dao.dart';
import 'package:moovi/database/userEntity.dart';
import 'package:moovi/database/user_dao.dart';

import 'database.dart';

Future<void> db() async {
  final database = await $FloorAppDatabase
      .databaseBuilder('flutter_database.db')
      .build();
  final movieDao = database.movieDao;
  final userDao = database.userDao;
  final friendsDao = database.friendsDao;
  final likedMoviesDao = database.likedMovieDao;

  final mvm = MainViewModel(movieDao, userDao, friendsDao, likedMoviesDao);
}

class MainViewModel{

  MovieDao _movieDao;
  UserDao _userDao;
  FriendsDao _friendsDao;
  LikedMoviesDao _likedMoviesDao;

  MainViewModel(this._movieDao, this._userDao, this._friendsDao, this._likedMoviesDao);

  //Getter methods
  void getUser(){

  }

  void getAllFriendsOfUser(){

  }

  void getAllPendingFriendsOfUser(){

  }

  void getMovies(){

  }

  void getMoviesOfGenre(){

  }

  void getLikedMoviesOfUser(){

  }

  void getSharedLikedMovies(){

  }


  //Add methods
  Future<void> addUser(String name, String userName, {String password = ""}) async {
      UserEntity user = UserEntity(null, name, userName, password);
      await _userDao.insertUser(user);
  }

  Future<void> addMovie(String title, String imageUrl, String mpaaRating, double imdbRating, String runtime, String genres, String synopsis) async {
      MovieEntity movie = MovieEntity(null, title, imageUrl, mpaaRating, imdbRating, runtime, genres, synopsis);
      await _movieDao.insertMovie(movie);
  }

  Future<void> addFriendToUser(String currentUserUsername, String friendUsername) async {
      final user = await _userDao.findUserByUsername(currentUserUsername);

  }

  void addPendingFriendToUser(String currentUsername, String friendUsername){

  }

  void addLikedMovieToUser(){

  }

  //remove methods
  void removeUser(){

  }

  void removeFriendFromUser(){

  }

  void removeLikedMovieFromUser(){

  }

}