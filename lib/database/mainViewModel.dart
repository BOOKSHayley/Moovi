

import 'package:flutter/cupertino.dart';
import 'package:moovi/database/database.dart';
import 'package:moovi/database/friendsEntity.dart';
import 'package:moovi/database/friends_dao.dart';
import 'package:moovi/database/likedMovieEntity.dart';
import 'package:moovi/database/likedMovie_dao.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/database/movie_dao.dart';
import 'package:moovi/database/userEntity.dart';
import 'package:moovi/database/user_dao.dart';


// CODE TO CREATE THE DATABASE -- BELOW IS WHAT TO ADD TO FILES WHERE YOU WANT TO USE DB
//   WidgetsFlutterBinding.ensureInitialized();
//   final _database = await DatabaseGetter.instance.database;
//   MainViewModel mvm = MainViewModel(_database);


class MainViewModel extends ChangeNotifier{

  late MovieDao _movieDao;
  late UserDao _userDao;
  late FriendsDao _friendsDao;
  late LikedMoviesDao _likedMoviesDao;

  MainViewModel(AppDatabase db){
    _movieDao = db.movieDao;
    _friendsDao = db.friendsDao;
    _userDao = db.userDao;
    _likedMoviesDao = db.likedMovieDao;
  }



  //Methods for getting from tables
  Future<UserEntity?> getUserbyUsername(String username) async{
      return await _userDao.findUserByUsername(username);
  }

  Future<UserEntity?> getUserbyId(int userId) async{
      return await _userDao.findUserById(userId);
  }

  Future<List<UserEntity?>> getAllUsers() async{
      return await _userDao.findAllUsers();
  }

  Future<List<UserEntity?>> getAllFriendsOfUser(String username, bool pendingFriends) async{
      final user = await getUserbyUsername(username);
      List<FriendsEntity> friendEntities = [];

      if(pendingFriends){
          friendEntities = await _friendsDao.findAllPendingFriendsOf(user!.id!);
      } else {
          friendEntities = await _friendsDao.findAllFriendsOf(user!.id!);
      }

      List<UserEntity?> friendUserEntities = [];

      for(var i = 0; i < friendEntities.length;i++){
          int friendId = friendEntities[i].userOneId;
          if(friendId == user.id){
            friendId = friendEntities[i].userTwoId;
          }

          friendUserEntities.add(await getUserbyId(friendId));
      }

      return friendUserEntities;
  }

  Future<List<MovieEntity>> getAllMovies() async{
      return await _movieDao.findAllMovies();
  }

  Future<List<MovieEntity>> getMoviesOfGenre(String genre) async{
      genre = "%" + genre + "%";
      return await _movieDao.findMoviesOfGenre(genre);
  }

  Future<MovieEntity?> getMovieByTitle(String title) async{
    return await _movieDao.findMovieByTitle(title);
  }

  Future<List<MovieEntity?>> getLikedMoviesOfUser(String username) async{
      final user = await _userDao.findUserByUsername(username);
      List<LikedMovieEntity?> likedMovieEntities = await _likedMoviesDao.findAllLikedMoviesOf(user!.id!);

      List<MovieEntity?> movies = [];
      for(int i = 0; i < likedMovieEntities.length; i++){
          movies.add(await _movieDao.findMovieById(likedMovieEntities[i]!.movieId));
      }
      return movies;
  }

  Future<List<MovieEntity?>> getSharedLikedMovies(String currentUserUsername, String friendUsername) async {
    List<MovieEntity?> currentUserLikedMovies = await getLikedMoviesOfUser(currentUserUsername);
    List<MovieEntity?> friendUserLikedMovies = await getLikedMoviesOfUser(friendUsername);

    List<MovieEntity?> sharedLikedMovies = [];
    for(int i = 0; i < currentUserLikedMovies.length; i++){
        for(int j = 0; j < friendUserLikedMovies.length; j++) {
            if (currentUserLikedMovies[i]!.id! == friendUserLikedMovies[j]!.id!) {
              sharedLikedMovies.add(currentUserLikedMovies[i]);
            }
        }
    }

    return sharedLikedMovies;
  }



  //Methods for adding to tables
  Future<void> addUser(String name, String userName, {String password = ""}) async {
      UserEntity? existingUser = await _userDao.findUserByUsername(userName);
      if(existingUser == null){
        UserEntity user = UserEntity(null, name, userName, password);
        return await _userDao.insertUser(user);
      }
  }

  Future<void> addMovie(String title, String imageUrl, String mpaaRating, double imdbRating, String runtime, String genres, String synopsis) async {
      MovieEntity movie = MovieEntity(null, title, imageUrl, mpaaRating, imdbRating, runtime, genres, synopsis);
      return await _movieDao.insertMovie(movie);
  }

  Future<void> addFriendToUser(String currentUserUsername, String friendUsername, bool pendingFriend) async {
      UserEntity? user = await getUserbyUsername(currentUserUsername);
      UserEntity? friend = await getUserbyUsername(friendUsername);
      FriendsEntity friendEntity = FriendsEntity(null, user!.id!, friend!.id!, pendingFriend);
      return await _friendsDao.insertFriend(friendEntity);
  }

  Future<void> updateFriendOfUserFromPending(String currentUserUsername, String friendUsername) async{
      final user = await getUserbyUsername(currentUserUsername);
      final friend = await getUserbyUsername(friendUsername);
      final friendEntity = await _friendsDao.findFriendOfUser(user!.id!, friend!.id!);
      final updatedFriendEntity = FriendsEntity(friendEntity!.id!, friendEntity.userOneId, friendEntity.userTwoId, false);
      await _friendsDao.deleteFriend(friendEntity);
      return await _friendsDao.insertFriend(updatedFriendEntity);
  }

  Future<void> addLikedMovieToUser(String username, String movieTitle) async{
      final user = await getUserbyUsername(username);
      final movie = await getMovieByTitle(movieTitle);
      LikedMovieEntity likedMovie = LikedMovieEntity(null, user!.id!, movie!.id!);
      return await _likedMoviesDao.insertLikedMovie(likedMovie);
  }



  //Methods for removing from tables
  Future<void> removeUser(String username) async{
      final user = await getUserbyUsername(username);
      return await _userDao.deleteUser(user!);
  }

  Future<void> removeFriendFromUser(String currentUserUsername, String friendUsername) async{
      final currentUser = await getUserbyUsername(currentUserUsername);
      final friendUser = await getUserbyUsername(friendUsername);
      final friendEntity = await _friendsDao.findFriendOfUser(currentUser!.id!, friendUser!.id!);
      return await _friendsDao.deleteFriend(friendEntity!);
  }

  Future<void> removeLikedMovieFromUser(String username, MovieEntity movie) async{
      final user = await getUserbyUsername(username);
      final likedMovie = await _likedMoviesDao.findLikedMovie(user!.id!, movie.id!);
      return await _likedMoviesDao.deleteLikedMovie(likedMovie!);
  }

  Future<void> deleteAllFriendsOfUser(String username) async{
      final user = await getUserbyUsername(username);
      return await _friendsDao.deleteAllFriendsOfUser(user!.id!);
  }

  Future<void> deleteAllLikedMoviesOfUser(String username) async{
      final user = await getUserbyUsername(username);
      return await _likedMoviesDao.deleteAllLikedMoviesFromUser(user!.id!);
  }



  //Methods for clearing tables
  Future<void> clearUserTable() async{
      return await _userDao.clearUserTable();
  }

  Future<void> clearFriendsTable() async{
    return await _friendsDao.clearFriendsTable();
  }

  Future<void> clearMovieTable() async{
    return await _movieDao.clearMovieTable();
  }

  Future<void> clearLikedMovieTable() async{
    return await _likedMoviesDao.clearLikedMovieTable();
  }

}