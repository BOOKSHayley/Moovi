
import 'package:floor/floor.dart';

@Entity(tableName: "users_table")
class UserEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name:"name")
  final String name;

  @ColumnInfo(name:"username")
  final String userName;

  @ColumnInfo(name:"password")
  final String password;

  @ColumnInfo(name:"number_of_clicks")
  int numClicks;

  UserEntity(this.id, this.name, this.userName, this.password, this.numClicks);

}