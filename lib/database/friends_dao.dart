// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:moovi/database/friendsEntity.dart';

@dao
abstract class FriendsDao {
  @Query('SELECT * FROM friends WHERE user_id = :userId and pending = 0')
  Future<List<FriendsEntity>> findAllFriendsOf(int userId);

  @Query('SELECT * FROM friends WHERE user_id = :userId and pending = 1')
  Future<List<FriendsEntity>> findAllPendingFriendsOf(int userId);

  @insert
  Future<void> insertFriend(FriendsEntity friend);

  @delete
  Future<void> deleteFriend(FriendsEntity friend);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateFriend(FriendsEntity friend);

}