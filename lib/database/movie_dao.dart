// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:moovi/database/movieEntity.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM movie_table')
  Future<List<MovieEntity>> findAllMovies();

  @Query('SELECT * FROM movie_table WHERE title = :title')
  Future<MovieEntity?> findMovieByTitle(String title);

  @Query('SELECT * FROM movie_table WHERE id = :id')
  Future<MovieEntity?> findMovieById(int id);

  @Query('SELECT * FROM movie_table WHERE genres LIKE :genre')
  Future<List<MovieEntity>> findMoviesOfGenre(String genre);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovie(MovieEntity movie);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertListOfMovies(List<MovieEntity> movies);

  @delete
  Future<void> deleteMovie(MovieEntity movie);

  @Query('DELETE FROM movie_table')
  Future<void> clearMovieTable();

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateMovie(MovieEntity movie);

}