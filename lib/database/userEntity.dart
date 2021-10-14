// database/person.dart

import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';

@Entity(tableName: "users")
class UserEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name:"name")
  final String name;

  @ColumnInfo(name:"username")
  final String userName;

  @ColumnInfo(name:"password")
  final String password;

  UserEntity(this.id, this.name, this.userName, this.password);
}