
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
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:moovi/friends/FriendsListMenu.dart';


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


  //Methods for getting Stream data from tables
  Stream<List<UserEntity?>> getAllFriendsOfUserAsStream(UserEntity user, bool pendingFriends) async*{
    yield await getAllFriendsOfUser(user, pendingFriends);
  }

  Stream<List<MovieEntity?>> getMoviesInPersonalQueueAsStream(UserEntity user, List<String>? genres) async*{
    if(genres == null) { genres = [""]; }
    yield await getAllMoviesInPersonalQueueOfGenre(user, genres);
  }

  Stream<List<MovieEntity?>> getLikedMoviesOfUserAsStream(UserEntity user) async*{
    yield await getLikedMoviesOfUser(user);
  }

  Stream<List<MovieEntity?>> getSharedLikedMoviesAsStream(UserEntity currentUser, UserEntity friend) async*{
    yield await getSharedLikedMovies(currentUser, friend);
  }



  //Methods for getting Future data from tables
  Future<UserEntity?> getUserbyUsername(String username) async{
    return await _userDao.findUserByUsername(username);
  }

  Future<UserEntity?> getUserbyUsernameAndPass(String username, String password) async{
    var data = utf8.encode(password);
    var hashedPass = sha256.convert(data).toString();
    return await _userDao.findUserByUsernameAndPass(username, hashedPass);
  }

  Future<UserEntity?> getUserbyId(int userId) async{
    return await _userDao.findUserById(userId);
  }

  Future<List<UserEntity?>> getAllUsers() async{
    return await _userDao.findAllUsers();
  }

  Future<List<UserEntity?>> getAllFriendsOfUser(UserEntity user, bool pendingFriends) async{
    List<FriendsEntity> friendEntities = [];
    FriendsListMenu.numSharedMovies.clear();

    if(pendingFriends){
      friendEntities = await _friendsDao.findAllPendingFriendsOf(user.id!);
    } else {
      friendEntities = await _friendsDao.findAllFriendsOf(user.id!);
    }

    List<UserEntity?> friendUserEntities = [];
    for(var i = 0; i < friendEntities.length;i++){
      FriendsListMenu.numSharedMovies.add(friendEntities[i].numSharedMovies);
      int friendId = friendEntities[i].userOneId;
      if(friendId == user.id){
        friendId = friendEntities[i].userTwoId;
      }

      friendUserEntities.add(await getUserbyId(friendId));
    }

    return friendUserEntities;
  }

  Future<FriendsEntity?> getFriendOfUser(UserEntity currentUser, UserEntity friend) async{
    return await _friendsDao.findFriendOfUser(currentUser.id!, friend.id!);
  }

  Future<List<MovieEntity?>> getAllMoviesInPersonalQueue(UserEntity user) async{
    return getAllMoviesInPersonalQueueOfGenre(user, [""]);
  }

  Future<List<MovieEntity?>> getAllMoviesInPersonalQueueOfGenre(UserEntity user, List<String> genres) async{
    final queue = await _personalQueueDao.findAllPersonalQueueMovies(user.id!);

    List<MovieEntity?> movies = [];
    for(int i = 0 ; i < queue.length; i++){
      for(int j = 0; j < genres.length; j++){
        String genre = "%" + genres[j] + "%";
        MovieEntity? m = await _movieDao.findMovieByIdAndGenre(queue[i].movieId, genre);
        if(m != null){
          movies.add(m);
          break;
        }
      }
    }

    return movies;
  }

  Future<List<MovieEntity>> getAllMovies() async{
    return await _movieDao.findAllMovies();
  }

  Future<List<MovieEntity>> getMoviesOfGenre(List<String> genres) async{
    List<MovieEntity> movies = [];
    for(int i = 0; i < genres.length; i++){
      String genre = "%" + genres[i] + "%";
      movies.addAll(await _movieDao.findMoviesOfGenre(genre));
    }

    return movies;
  }

  Future<MovieEntity?> getMovieByTitle(String title) async{
    return await _movieDao.findMovieByTitle(title);
  }

  Future<List<MovieEntity?>> getLikedMoviesOfUser(UserEntity user) async{
    List<LikedMovieEntity?> likedMovieEntities = await _likedMoviesDao.findAllLikedMoviesOf(user.id!);

    List<MovieEntity?> movies = [];
    for(int i = 0; i < likedMovieEntities.length; i++){
      movies.add(await _movieDao.findMovieById(likedMovieEntities[i]!.movieId));
    }
    return movies;
  }

  Future<List<MovieEntity?>> getSharedLikedMovies(UserEntity currentUser, UserEntity friend) async {
    List<MovieEntity?> currentUserLikedMovies = await getLikedMoviesOfUser(currentUser);
    List<MovieEntity?> friendUserLikedMovies = await getLikedMoviesOfUser(friend);

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
  Future<bool> addUser(String name, String userName, {String password = ""}) async {
    UserEntity? existingUser = await _userDao.findUserByUsername(userName);
    if(existingUser == null){
      var data = utf8.encode(password);
      var hashedPass = sha256.convert(data).toString();
      print(hashedPass);
      UserEntity user = UserEntity(null, name, userName, hashedPass, 0);
      int id = await _userDao.insertUser(user);
      addAllMoviesToUserPersonalQueue(id);
      return true;
    }
    return false;
  }

  Future<void> addMovie(String title, String imageUrl, String mpaaRating, double imdbRating, String runtime, String genres, int year, String streamingService, String synopsis) async {
    MovieEntity movie = MovieEntity(null, title, imageUrl, mpaaRating, imdbRating, runtime, genres, year, streamingService, synopsis);
    int movieId = await _movieDao.insertMovie(movie);
    _addMovieToPersonalQueues(movieId);
  }

  Future<void> _addMovieToPersonalQueues(int movieId) async{
    List<UserEntity?> users = await getAllUsers();
    for(int i = 0 ; i < users.length; i++){
      PersonalQueueEntity pqe = new PersonalQueueEntity(null, users[i]!.id!, movieId, 1);
      _personalQueueDao.insertPersonalQueueMovie(pqe);
    }
  }

  Future<bool> addFriendToUser(UserEntity currentUser, String friendUsername, bool pendingFriend) async {
    UserEntity? friend = await getUserbyUsername(friendUsername);
    if(friend == null){ return false; }
    final existingFriend = await getFriendOfUser(currentUser, friend);
    if(existingFriend != null){ return false; }
    FriendsEntity friendEntity = FriendsEntity(null, currentUser.id!, friend.id!, pendingFriend, 0);
    _friendsDao.insertFriend(friendEntity);
    return true;
  }

  Future<void> addLikedMovieToUser(UserEntity user, MovieEntity movie) async{
    LikedMovieEntity likedMovie = LikedMovieEntity(null, user.id!, movie.id!);
    _likedMoviesDao.insertLikedMovie(likedMovie);
    _updateAllFriendCounts(user, movie);
  }

  Future<void> addAllMoviesToUserPersonalQueue(int userId) async{
    final allMovies = await getAllMovies();
    final List<PersonalQueueEntity> personalQEntities = [];
    for(int i = 0; i < allMovies.length; i++){
      personalQEntities.add(PersonalQueueEntity(null, userId, allMovies[i].id!, 1));
    }
    _personalQueueDao.insertPersonalQueueListOfMovies(personalQEntities);
  }

  Future<void> lowerPersonalQueueMoviePriority(UserEntity user, MovieEntity movie) async{
    final pqMovie = await _personalQueueDao.findPersonalQueueMovie(user.id!, movie.id!);
    final oldPriority = pqMovie!.priority;
    final newMovie = PersonalQueueEntity(pqMovie.id!, pqMovie.userId, pqMovie.movieId, oldPriority+1);
    await _personalQueueDao.deletePersonalQueueMovie(pqMovie);
    _personalQueueDao.insertPersonalQueueMovie(newMovie);
  }


  //Methods for updating rows
  Future<void> updateFriendOfUserFromPending(UserEntity currentUser, UserEntity friend) async{
    final friendEntity = await getFriendOfUser(currentUser, friend);
    final updatedFriendEntity = FriendsEntity(friendEntity!.id!, friendEntity.userOneId, friendEntity.userTwoId, false, 0);
    _friendsDao.deleteFriend(friendEntity);
    _friendsDao.insertFriend(updatedFriendEntity);

    List<MovieEntity?> existingSharedMovies = await getSharedLikedMovies(currentUser, friend);
    updateFriendSharedMovieCount(currentUser, friend, existingSharedMovies.length);
  }

  Future<void> updateUserClicks(UserEntity user, int clicks) async{
    user.numClicks += clicks;
    return await _userDao.updateUser(user);
  }

  Future<void> updateFriendSharedMovieCount(UserEntity currentUser, UserEntity friend, int count) async{
    FriendsEntity? friendEntity = await getFriendOfUser(currentUser, friend);
    friendEntity!.numSharedMovies += count;
    return await _friendsDao.updateFriend(friendEntity);
  }

  Future<void> _updateAllFriendCounts(UserEntity currentUser, MovieEntity likedMovie) async{
    List<UserEntity?> friends = await getAllFriendsOfUser(currentUser, false);
    for(int i = 0; i < friends.length; i++){
      if(friends[i] == null) { continue; }

      LikedMovieEntity? sharedMovie = await _likedMoviesDao.findLikedMovie(friends[i]!.id!, likedMovie.id!);
      if(sharedMovie != null){
        updateFriendSharedMovieCount(currentUser, friends[i]!, 1);
      }

    }
  }


  //Methods for removing from tables
  Future<void> removeUser(UserEntity user) async{
    _userDao.deleteUser(user);
  }

  Future<void> removeFriendFromUser(UserEntity currentUser, UserEntity friend) async{
    final friendEntity = await _friendsDao.findFriendOfUser(currentUser.id!, friend.id!);
    _friendsDao.deleteFriend(friendEntity!);
  }

  Future<void> removeLikedMovieFromUser(UserEntity user, MovieEntity movie) async{
    final likedMovie = await _likedMoviesDao.findLikedMovie(user.id!, movie.id!);
    _likedMoviesDao.deleteLikedMovie(likedMovie!);
  }

  Future<void> removePersonalQueueMovie(UserEntity user, MovieEntity movie) async{
    PersonalQueueEntity? pqe = await _personalQueueDao.findPersonalQueueMovie(user.id!, movie.id!);
    _personalQueueDao.deletePersonalQueueMovie(pqe!);
  }

  Future<void> deleteAllFriendsOfUser(UserEntity user) async{
    _friendsDao.deleteAllFriendsOfUser(user.id!);
  }

  Future<void> deleteAllLikedMoviesOfUser(UserEntity user) async{
    _likedMoviesDao.deleteAllLikedMoviesFromUser(user.id!);
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