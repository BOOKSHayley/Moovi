// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:moovi/database/userEntity.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM users_table')
  Future<List<UserEntity>> findAllUsers();

  @Query('SELECT * FROM users_table WHERE username = :userName')
  Future<UserEntity?> findUserByUsername(String userName);

  @Query('SELECT * FROM users_table WHERE id = :id')
  Future<UserEntity?> findUserById(int id);

  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> insertUser(UserEntity user);

  @delete
  Future<void> deleteUser(UserEntity user);

  @Query('DELETE FROM users_table')
  Future<void> clearUserTable();

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUser(UserEntity user);

}