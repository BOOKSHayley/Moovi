import 'package:floor/floor.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/database/personalQueueEntity.dart';

@dao
abstract class PersonalQueueDao {
  @Query('SELECT * FROM personal_queue_table WHERE user_id = :userId ORDER BY priority')
  Future<List<PersonalQueueEntity>> findAllPersonalQueueMovies(int userId);

  @Query('SELECT * FROM personal_queue_table WHERE user_id = :userId ORDER BY priority')
  Stream<List<PersonalQueueEntity>> findAllPersonalQueueMoviesAsStream(int userId);

  @Query('SELECT * FROM personal_queue_tabLE WHERE user_id = :userId AND movie_id = :movieId')
  Future<PersonalQueueEntity?> findPersonalQueueMovie(int userId, int movieId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPersonalQueueMovie(PersonalQueueEntity movie);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPersonalQueueListOfMovies(List<PersonalQueueEntity> movies);

  @delete
  Future<void> deletePersonalQueueMovie(PersonalQueueEntity movie);

  @Query('DELETE FROM personal_queue_table')
  Future<void> clearPersonalQueueMovieTable();

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updatePersonalQueueMovie(PersonalQueueEntity movie);

}