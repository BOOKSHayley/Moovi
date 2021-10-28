


import 'package:moovi/database/database.dart';

class DatabaseGetter{
  static final _databaseName = 'flutter_database_v1.db';

  DatabaseGetter._privateConstructor();
  static final DatabaseGetter instance = DatabaseGetter._privateConstructor();

  static AppDatabase? _database;
  static var dao;
  Future<AppDatabase> get database async{
    if(_database !=null){
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async{
    return await $FloorAppDatabase
        .databaseBuilder(_databaseName)
        .build();
  }

  static resetDatabase() {
    _database = null;
  }

}