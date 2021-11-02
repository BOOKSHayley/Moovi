

import 'package:flutter/cupertino.dart';
import 'package:moovi/database/database.dart';
import 'package:moovi/database/friendsEntity.dart';
import 'package:moovi/database/friends_dao.dart';
import 'package:moovi/database/likedMovieEntity.dart';
import 'package:moovi/database/likedMovie_dao.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/database/movie_dao.dart';
import 'package:moovi/database/personalQueueEntity.dart';
import 'package:moovi/database/personal_queue_dao.dart';
import 'package:moovi/database/userEntity.dart';
import 'package:moovi/database/user_dao.dart';
import 'package:moovi/movie/Movie.dart';


// CODE TO CREATE THE DATABASE -- BELOW IS WHAT TO ADD TO FILES WHERE YOU WANT TO USE DB
//   WidgetsFlutterBinding.ensureInitialized();
//   final _database = await DatabaseGetter.instance.database;
//   MainViewModel mvm = MainViewModel(_database);


class MainViewModel extends ChangeNotifier{

  late MovieDao _movieDao;
  late UserDao _userDao;
  late FriendsDao _friendsDao;
  late LikedMoviesDao _likedMoviesDao;
  late PersonalQueueDao _personalQueueDao;

  MainViewModel(AppDatabase db){
    _movieDao = db.movieDao;
    _friendsDao = db.friendsDao;
    _userDao = db.userDao;
    _likedMoviesDao = db.likedMovieDao;
    _personalQueueDao = db.personalQueueDao;
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

  Future<List<MovieEntity?>> getAllMoviesInPersonalQueue(String username) async{
      return getAllMoviesInPersonalQueueOfGenre(username, "");
  }

  Future<List<MovieEntity?>> getAllMoviesInPersonalQueueOfGenre(String username, String genre) async{
      final user = await getUserbyUsername(username);
      final queue = await _personalQueueDao.findAllPersonalQueueMovies(user!.id!);

      genre = "%" + genre + "%";
      List<MovieEntity?> movies = [];
      for(int i = 0 ; i < queue.length; i++){
          movies.add(await _movieDao.findMovieByIdAndGenre(queue[i].movieId, genre));
      }
      return movies;
  }

  Stream<List<MovieEntity?>> getMoviesInPersonalQueueAsStream(String username) async*{
      yield await getAllMoviesInPersonalQueueOfGenre(username, "");
  }

  Stream<List<MovieEntity?>> getAllMoviesInPersonalQueueOfGenreAsStream(String username, String genre) async*{
    final user = await getUserbyUsername(username);
    List<MovieEntity?> movies = [];
    genre = "%" + genre + "%";
    Stream<List<PersonalQueueEntity>> queue = _personalQueueDao.findAllPersonalQueueMoviesAsStream(user!.id!);
    await for(List<PersonalQueueEntity> queueList in queue){
      for(int i = 0 ; i < queueList.length; i++){
        movies.add(await _movieDao.findMovieByIdAndGenre(queueList[i].movieId, genre));
      }
    }
    yield movies;
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

  Stream<List<MovieEntity?>> getLikedMoviesOfUserAsStream(String username) async*{
      final user = await getUserbyUsername(username);
      Stream<List<LikedMovieEntity>> likedMovies = _likedMoviesDao.findAllLikedMoviesOfUserAsStream(user!.id!);
      List<MovieEntity?> movies = [];
      await for (List<LikedMovieEntity> lm in likedMovies){
          for(int i = 0; i < lm.length; i++) {
             movies.add(await _movieDao.findMovieById(lm[i].movieId));
          }
      }
      yield movies;
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


  Stream<List<MovieEntity?>> getSharedLikedMoviesAsStream(String currentUserUsername, String friendUsername) async*{
    Stream<List<MovieEntity?>> currentUserLikedMovies = getLikedMoviesOfUserAsStream(currentUserUsername);
    Stream<List<MovieEntity?>> friendUserLikedMovies = getLikedMoviesOfUserAsStream(friendUsername);
    List<MovieEntity?> sharedLikedMovies = [];
    await for(List<MovieEntity?> currentLM in currentUserLikedMovies){
        await for(List<MovieEntity?> friendLM in friendUserLikedMovies){
            for(int i = 0; i < currentLM.length; i++){
                for(int j = 0; j < friendLM.length; j++) {
                    if (currentLM[i]!.id! == friendLM[j]!.id!) {
                      sharedLikedMovies.add(currentLM[i]);
                    }
                }
            }
        }
    }

    yield sharedLikedMovies;
  }



  //Methods for adding to tables
  Future<bool> addUser(String name, String userName, {String password = ""}) async {
      UserEntity? existingUser = await _userDao.findUserByUsername(userName);
      if(existingUser == null){
        UserEntity user = UserEntity(null, name, userName, password);
        _userDao.insertUser(user);
        addAllMoviesToUserPersonalQueue(user);
        return true;
      }
      return false;
  }

  Future<void> addMovie(String title, String imageUrl, String mpaaRating, double imdbRating, String runtime, String genres, String synopsis) async {
      MovieEntity movie = MovieEntity(null, title, imageUrl, mpaaRating, imdbRating, runtime, genres, synopsis);
      int movieId = await _movieDao.insertMovie(movie);
      _addMovieToPersonalQueue(movieId);
  }

  Future<void> _addMovieToPersonalQueue(int movieId) async{
      List<UserEntity?> users = await getAllUsers();
      for(int i = 0 ; i < users.length; i++){
        PersonalQueueEntity pqe = new PersonalQueueEntity(null, users[i]!.id!, movieId, 1);
        _personalQueueDao.insertPersonalQueueMovie(pqe);
      }
  }

  Future<void> addFriendToUser(String currentUserUsername, String friendUsername, bool pendingFriend) async {
      UserEntity? user = await getUserbyUsername(currentUserUsername);
      UserEntity? friend = await getUserbyUsername(friendUsername);
      FriendsEntity friendEntity = FriendsEntity(null, user!.id!, friend!.id!, pendingFriend);
      _friendsDao.insertFriend(friendEntity);
  }

  Future<void> updateFriendOfUserFromPending(String currentUserUsername, String friendUsername) async{
      final user = await getUserbyUsername(currentUserUsername);
      final friend = await getUserbyUsername(friendUsername);
      final friendEntity = await _friendsDao.findFriendOfUser(user!.id!, friend!.id!);
      final updatedFriendEntity = FriendsEntity(friendEntity!.id!, friendEntity.userOneId, friendEntity.userTwoId, false);
      _friendsDao.deleteFriend(friendEntity);
      _friendsDao.insertFriend(updatedFriendEntity);
  }

  Future<void> addLikedMovieToUser(String username, MovieEntity movie) async{
      final user = await getUserbyUsername(username);
      LikedMovieEntity likedMovie = LikedMovieEntity(null, user!.id!, movie.id!);
      _likedMoviesDao.insertLikedMovie(likedMovie);
  }

  Future<void> addAllMoviesToUserPersonalQueue(UserEntity user) async{
      final allMovies = await getAllMovies();
      final List<PersonalQueueEntity> personalQEntities = [];
      for(int i = 0; i < allMovies.length; i++){
          personalQEntities.add(PersonalQueueEntity(null, user.id!, allMovies[i].id!, 1));
      }
      _personalQueueDao.insertPersonalQueueListOfMovies(personalQEntities);
  }

  Future<void> lowerPersonalQueueMoviePriority(String username, MovieEntity movie) async{
      final user = await getUserbyUsername(username);
      final pqMovie = await _personalQueueDao.findPersonalQueueMovie(user!.id!, movie.id!);
      final oldPriority = pqMovie!.priority;
      final newMovie = PersonalQueueEntity(pqMovie.id!, pqMovie.userId, pqMovie.movieId, oldPriority+1);
      await _personalQueueDao.deletePersonalQueueMovie(pqMovie);
      _personalQueueDao.insertPersonalQueueMovie(newMovie);
  }



  //Methods for removing from tables
  Future<void> removeUser(String username) async{
      final user = await getUserbyUsername(username);
      _userDao.deleteUser(user!);
  }

  Future<void> removeFriendFromUser(String currentUserUsername, String friendUsername) async{
      final currentUser = await getUserbyUsername(currentUserUsername);
      final friendUser = await getUserbyUsername(friendUsername);
      final friendEntity = await _friendsDao.findFriendOfUser(currentUser!.id!, friendUser!.id!);
      _friendsDao.deleteFriend(friendEntity!);
  }

  Future<void> removeLikedMovieFromUser(String username, MovieEntity movie) async{
      final user = await getUserbyUsername(username);
      final likedMovie = await _likedMoviesDao.findLikedMovie(user!.id!, movie.id!);
      _likedMoviesDao.deleteLikedMovie(likedMovie!);
  }

  Future<void> removePersonalQueueMovie(String username, MovieEntity movie) async{
      UserEntity? user = await getUserbyUsername(username);
      PersonalQueueEntity? pqe = await _personalQueueDao.findPersonalQueueMovie(user!.id!, movie.id!);
      _personalQueueDao.deletePersonalQueueMovie(pqe!);
  }

  Future<void> deleteAllFriendsOfUser(String username) async{
      final user = await getUserbyUsername(username);
      _friendsDao.deleteAllFriendsOfUser(user!.id!);
  }

  Future<void> deleteAllLikedMoviesOfUser(String username) async{
      final user = await getUserbyUsername(username);
      _likedMoviesDao.deleteAllLikedMoviesFromUser(user!.id!);
  }



  //Methods for clearing tables
  Future<void> clearUserTable() async{
      _userDao.clearUserTable();
  }

  Future<void> clearFriendsTable() async{
      _friendsDao.clearFriendsTable();
  }

  Future<void> clearMovieTable() async{
    _movieDao.clearMovieTable();
  }

  Future<void> clearLikedMovieTable() async{
    _likedMoviesDao.clearLikedMovieTable();
  }

  Future<void> clearPersonalQueueTable() async{
    _personalQueueDao.clearPersonalQueueMovieTable();
  }

  Future<void> clearAllTables() async{
    clearFriendsTable();
    clearMovieTable();
    clearUserTable();
    clearLikedMovieTable();
    clearPersonalQueueTable();
  }

}