// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:moovi/database/movieEntity.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM movie')
  Future<List<MovieEntity>> findAllMovies();

  @Query('SELECT * FROM movie WHERE title = :title')
  Stream<MovieEntity?> findMovieByTitle(String title);

  @Query('SELECT * FROM movie WHERE id = :id')
  Stream<MovieEntity?> findMovieById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovie(MovieEntity movie);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertListOfMovies(List<MovieEntity> movies);

  @delete
  Future<void> deleteMovie(MovieEntity movie);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateMovie(MovieEntity movie);

}