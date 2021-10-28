// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:moovi/database/friendsEntity.dart';

@dao
abstract class FriendsDao {
  @Query('SELECT * FROM friends_table WHERE (user_one_id = :userId OR user_two_id = :userId) AND pending = 0')
  Future<List<FriendsEntity>> findAllFriendsOf(int userId);

  @Query('SELECT * FROM friends_table WHERE (user_one_id = :userId OR user_two_id = :userId) AND pending = 0')
  Stream<List<FriendsEntity>> findAllFriendsOfUserAsStream(int userId);

  @Query('SELECT * FROM friends_table WHERE (user_one_id = :userId OR user_two_id = :userId) AND pending = 1')
  Future<List<FriendsEntity>> findAllPendingFriendsOf(int userId);

  @Query('SELECT * FROM friends_table WHERE (user_one_id = :userId OR user_two_id = :userId) AND pending = 1')
  Stream<List<FriendsEntity>> findAllPendingFriendsOfUserAsStream(int userId);

  @Query('SELECT * FROM friends_table WHERE (user_one_id = :userId AND user_two_id = :friendId) OR (user_one_id = :friendId AND user_two_id = :userId)')
  Future<FriendsEntity?> findFriendOfUser(int userId, int friendId);

  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> insertFriend(FriendsEntity friend);

  @delete
  Future<void> deleteFriend(FriendsEntity friend);

  @Query('DELETE FROM friends_table WHERE user_one_id = :userId OR user_two_id = :userId')
  Future<void> deleteAllFriendsOfUser(int userId);

  @Query('DELETE FROM friends_table')
  Future<void> clearFriendsTable();

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateFriend(FriendsEntity friend);

}