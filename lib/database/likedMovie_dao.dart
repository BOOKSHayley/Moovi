// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:moovi/database/likedMovieEntity.dart';

@dao
abstract class LikedMoviesDao {
  @Query('SELECT * FROM liked_movies_table WHERE user_id = :userId')
  Future<List<LikedMovieEntity>> findAllLikedMoviesOf(int userId);

  @Query('SELECT * FROM liked_movies_table WHERE user_id = :userId AND movie_id = :movieId')
  Future<LikedMovieEntity?> findLikedMovie(int userId, int movieId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertLikedMovie(LikedMovieEntity likedMovie);

  @delete
  Future<void> deleteLikedMovie(LikedMovieEntity likedMovie);

  @Query('DELETE FROM liked_movies_table WHERE user_id = :userId')
  Future<void> deleteAllLikedMoviesFromUser(int userId);

  @Query('DELETE FROM liked_movies_table')
  Future<void> clearLikedMovieTable();
}