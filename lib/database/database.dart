// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:moovi/database/friends_dao.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/database/movie_dao.dart';
import 'package:moovi/database/personalQueueEntity.dart';
import 'package:moovi/database/personal_queue_dao.dart';
import 'package:moovi/database/userEntity.dart';
import 'package:moovi/database/user_dao.dart';
import 'package:moovi/database/likedMovie_dao.dart';
import 'package:moovi/database/friendsEntity.dart';
import 'package:moovi/database/likedMovieEntity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

// run   flutter packages pub run build_runner build   in the terminal to update database

@Database(version: 1, entities: [MovieEntity, UserEntity, FriendsEntity, LikedMovieEntity, PersonalQueueEntity])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
  UserDao get userDao;
  FriendsDao get friendsDao;
  LikedMoviesDao get likedMovieDao;
  PersonalQueueDao get personalQueueDao;
}