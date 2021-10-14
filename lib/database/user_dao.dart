// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:moovi/database/userEntity.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM users')
  Future<List<UserEntity>> findAllUsers();

  @Query('SELECT * FROM users WHERE username = :userName')
  Stream<UserEntity?> findUserByUsername(String userName);

  @Query('SELECT * FROM users WHERE id = :id')
  Stream<UserEntity?> findUserById(int id);

  @insert
  Future<void> insertUser(UserEntity user);

  @delete
  Future<void> deleteUser(UserEntity user);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUser(UserEntity user);

}