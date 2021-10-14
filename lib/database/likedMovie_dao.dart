// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:moovi/database/likedMovieEntity.dart';

@dao
abstract class LikedMoviesDao {
  @Query('SELECT * FROM liked_movies WHERE user_id = :userId')
  Future<List<LikedMovieEntity>> findAllLikedMoviesOf(int userId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertLikedMovie(LikedMovieEntity likedMovie);

  @delete
  Future<void> deleteLikedMovie(LikedMovieEntity likedMovie);
}