// database/person.dart

import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:moovi/database/userEntity.dart';

@Entity(
    tableName: "friends",
    foreignKeys: [
      ForeignKey(
          childColumns: ['user_id'],
          parentColumns: ['id'],
          entity: UserEntity,
          onDelete: ForeignKeyAction.cascade, //If the user is deleted, delete the associated rows
          onUpdate: ForeignKeyAction.cascade //If the user id is updated, update the associated rows
      ),
      ForeignKey(
          childColumns: ['friend_id'],
          parentColumns: ['id'],
          entity: UserEntity,
          onDelete: ForeignKeyAction.cascade, //If the friend is deleted, delete the associated rows
          onUpdate: ForeignKeyAction.cascade //If the friend id is updated, update the associated rows
      )
    ]
)
class FriendsEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  //Foreign Key to current user
  @ColumnInfo(name:"user_id")
  final int userId;

  //Foreign Key to current user's friend
  @ColumnInfo(name:"friend_id")
  final int friendId;

  //Is the friend pending or accepted
  @ColumnInfo(name:"pending")
  final bool pending;

  FriendsEntity(this.id, this.userId, this.friendId, this.pending);
}