// database/person.dart

import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:moovi/database/userEntity.dart';
import 'package:moovi/database/movieEntity.dart';

@Entity(
    tableName: "liked_movies_table",
    foreignKeys: [
      ForeignKey(
        childColumns: ['user_id'],
        parentColumns: ['id'],
        entity: UserEntity,
        onDelete: ForeignKeyAction.cascade, //If the user is deleted, delete the associated rows
        onUpdate: ForeignKeyAction.cascade //If the user id is updated, update the associated rows
      ),
      ForeignKey(
          childColumns: ['movie_id'],
          parentColumns: ['id'],
          entity: MovieEntity,
          onUpdate: ForeignKeyAction.cascade, //If movie id updates, update associated rows
          onDelete: ForeignKeyAction.cascade //If movie is deleted, delete associated row
      )
    ]
)
class LikedMovieEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name:"user_id")
  final int userId;

  @ColumnInfo(name:"movie_id")
  final int movieId;

  LikedMovieEntity(this.id, this.userId, this.movieId);
}