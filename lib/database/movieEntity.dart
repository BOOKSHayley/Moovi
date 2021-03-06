
import 'package:floor/floor.dart';

@Entity(tableName: "movie_table")
class MovieEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name:"title")
  final String title;

  @ColumnInfo(name:"image")
  final String imageUrl;

  @ColumnInfo(name: "MPAA_rating")
  final String mpaa;

  @ColumnInfo(name: "IMDB_rating")
  final double imdb;

  @ColumnInfo(name: "runtime")
  final String runtime;

  @ColumnInfo(name:"genres")
  final String genres;

  @ColumnInfo(name:"year")
  final int year;

  @ColumnInfo(name:"streaming_service")
  final String streamingService;

  @ColumnInfo(name:"synopsis")
  final String synopsis;

  MovieEntity(this.id, this.title, this.imageUrl, this.mpaa, this.imdb, this.runtime, this.genres, this.year, this.streamingService, this.synopsis);
}