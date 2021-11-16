// database/person.dart

import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:moovi/database/userEntity.dart';

@Entity(
    tableName: "friends_table",
    foreignKeys: [
      ForeignKey(
          childColumns: ['user_one_id'],
          parentColumns: ['id'],
          entity: UserEntity,
          onDelete: ForeignKeyAction.cascade, //If the 1st user is deleted, delete the associated rows
          onUpdate: ForeignKeyAction.cascade //If the 1st user id is updated, update the associated rows
      ),
      ForeignKey(
          childColumns: ['user_two_id'],
          parentColumns: ['id'],
          entity: UserEntity,
          onDelete: ForeignKeyAction.cascade, //If the 2nd user is deleted, delete the associated rows
          onUpdate: ForeignKeyAction.cascade //If the 2nd user id is updated, update the associated rows
      )
    ]
)
class FriendsEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  //Foreign Key to current user
  @ColumnInfo(name:"user_one_id")
  final int userOneId;

  //Foreign Key to current user's friend
  @ColumnInfo(name:"user_two_id")
  final int userTwoId;

  //Is the friend pending or accepted
  @ColumnInfo(name:"pending")
  final bool pending;

  @ColumnInfo(name:"num_shared_movies")
  int numSharedMovies;

  FriendsEntity(this.id, this.userOneId, this.userTwoId, this.pending, this.numSharedMovies);
}