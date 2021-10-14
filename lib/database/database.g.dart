// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  UserDao? _userDaoInstance;

  FriendsDao? _friendsDaoInstance;

  LikedMoviesDao? _likedMovieDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `movie` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `title` TEXT NOT NULL, `image` TEXT NOT NULL, `MPAA_rating` TEXT NOT NULL, `IMDB_rating` REAL NOT NULL, `runtime` TEXT NOT NULL, `genres` TEXT NOT NULL, `synopsis` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL, `username` TEXT NOT NULL, `password` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `friends` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `user_id` INTEGER NOT NULL, `friend_id` INTEGER NOT NULL, `pending` INTEGER NOT NULL, FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`friend_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `liked_movies` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `user_id` INTEGER NOT NULL, `movie_id` INTEGER NOT NULL, FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`) ON UPDATE CASCADE ON DELETE CASCADE)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  FriendsDao get friendsDao {
    return _friendsDaoInstance ??= _$FriendsDao(database, changeListener);
  }

  @override
  LikedMoviesDao get likedMovieDao {
    return _likedMovieDaoInstance ??=
        _$LikedMoviesDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _movieEntityInsertionAdapter = InsertionAdapter(
            database,
            'movie',
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'image': item.imageUrl,
                  'MPAA_rating': item.mpaa,
                  'IMDB_rating': item.imdb,
                  'runtime': item.runtime,
                  'genres': item.genres,
                  'synopsis': item.synopsis
                },
            changeListener),
        _movieEntityUpdateAdapter = UpdateAdapter(
            database,
            'movie',
            ['id'],
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'image': item.imageUrl,
                  'MPAA_rating': item.mpaa,
                  'IMDB_rating': item.imdb,
                  'runtime': item.runtime,
                  'genres': item.genres,
                  'synopsis': item.synopsis
                },
            changeListener),
        _movieEntityDeletionAdapter = DeletionAdapter(
            database,
            'movie',
            ['id'],
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'image': item.imageUrl,
                  'MPAA_rating': item.mpaa,
                  'IMDB_rating': item.imdb,
                  'runtime': item.runtime,
                  'genres': item.genres,
                  'synopsis': item.synopsis
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieEntity> _movieEntityInsertionAdapter;

  final UpdateAdapter<MovieEntity> _movieEntityUpdateAdapter;

  final DeletionAdapter<MovieEntity> _movieEntityDeletionAdapter;

  @override
  Future<List<MovieEntity>> findAllMovies() async {
    return _queryAdapter.queryList('SELECT * FROM movie',
        mapper: (Map<String, Object?> row) => MovieEntity(
            row['id'] as int,
            row['title'] as String,
            row['image'] as String,
            row['MPAA_rating'] as String,
            row['IMDB_rating'] as double,
            row['runtime'] as String,
            row['genres'] as String,
            row['synopsis'] as String));
  }

  @override
  Stream<MovieEntity?> findMovieByTitle(String title) {
    return _queryAdapter.queryStream('SELECT * FROM movie WHERE title = ?1',
        mapper: (Map<String, Object?> row) => MovieEntity(
            row['id'] as int,
            row['title'] as String,
            row['image'] as String,
            row['MPAA_rating'] as String,
            row['IMDB_rating'] as double,
            row['runtime'] as String,
            row['genres'] as String,
            row['synopsis'] as String),
        arguments: [title],
        queryableName: 'movie',
        isView: false);
  }

  @override
  Stream<MovieEntity?> findMovieById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM movie WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieEntity(
            row['id'] as int,
            row['title'] as String,
            row['image'] as String,
            row['MPAA_rating'] as String,
            row['IMDB_rating'] as double,
            row['runtime'] as String,
            row['genres'] as String,
            row['synopsis'] as String),
        arguments: [id],
        queryableName: 'movie',
        isView: false);
  }

  @override
  Future<void> insertMovie(MovieEntity movie) async {
    await _movieEntityInsertionAdapter.insert(
        movie, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertListOfMovies(List<MovieEntity> movies) async {
    await _movieEntityInsertionAdapter.insertList(
        movies, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateMovie(MovieEntity movie) async {
    await _movieEntityUpdateAdapter.update(movie, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteMovie(MovieEntity movie) async {
    await _movieEntityDeletionAdapter.delete(movie);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'username': item.userName,
                  'password': item.password
                },
            changeListener),
        _userEntityUpdateAdapter = UpdateAdapter(
            database,
            'users',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'username': item.userName,
                  'password': item.password
                },
            changeListener),
        _userEntityDeletionAdapter = DeletionAdapter(
            database,
            'users',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'username': item.userName,
                  'password': item.password
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  final UpdateAdapter<UserEntity> _userEntityUpdateAdapter;

  final DeletionAdapter<UserEntity> _userEntityDeletionAdapter;

  @override
  Future<List<UserEntity>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM users',
        mapper: (Map<String, Object?> row) => UserEntity(
            row['id'] as int,
            row['name'] as String,
            row['username'] as String,
            row['password'] as String));
  }

  @override
  Stream<UserEntity?> findUserByUsername(String userName) {
    return _queryAdapter.queryStream('SELECT * FROM users WHERE username = ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            row['id'] as int,
            row['name'] as String,
            row['username'] as String,
            row['password'] as String),
        arguments: [userName],
        queryableName: 'users',
        isView: false);
  }

  @override
  Stream<UserEntity?> findUserById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM users WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            row['id'] as int,
            row['name'] as String,
            row['username'] as String,
            row['password'] as String),
        arguments: [id],
        queryableName: 'users',
        isView: false);
  }

  @override
  Future<void> insertUser(UserEntity user) async {
    await _userEntityInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    await _userEntityUpdateAdapter.update(user, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteUser(UserEntity user) async {
    await _userEntityDeletionAdapter.delete(user);
  }
}

class _$FriendsDao extends FriendsDao {
  _$FriendsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _friendsEntityInsertionAdapter = InsertionAdapter(
            database,
            'friends',
            (FriendsEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.userId,
                  'friend_id': item.friendId,
                  'pending': item.pending ? 1 : 0
                }),
        _friendsEntityUpdateAdapter = UpdateAdapter(
            database,
            'friends',
            ['id'],
            (FriendsEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.userId,
                  'friend_id': item.friendId,
                  'pending': item.pending ? 1 : 0
                }),
        _friendsEntityDeletionAdapter = DeletionAdapter(
            database,
            'friends',
            ['id'],
            (FriendsEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.userId,
                  'friend_id': item.friendId,
                  'pending': item.pending ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FriendsEntity> _friendsEntityInsertionAdapter;

  final UpdateAdapter<FriendsEntity> _friendsEntityUpdateAdapter;

  final DeletionAdapter<FriendsEntity> _friendsEntityDeletionAdapter;

  @override
  Future<List<FriendsEntity>> findAllFriendsOf(int userId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM friends WHERE user_id = ?1 and pending = 0',
        mapper: (Map<String, Object?> row) => FriendsEntity(
            row['id'] as int,
            row['user_id'] as int,
            row['friend_id'] as int,
            (row['pending'] as int) != 0),
        arguments: [userId]);
  }

  @override
  Future<List<FriendsEntity>> findAllPendingFriendsOf(int userId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM friends WHERE user_id = ?1 and pending = 1',
        mapper: (Map<String, Object?> row) => FriendsEntity(
            row['id'] as int,
            row['user_id'] as int,
            row['friend_id'] as int,
            (row['pending'] as int) != 0),
        arguments: [userId]);
  }

  @override
  Future<void> insertFriend(FriendsEntity friend) async {
    await _friendsEntityInsertionAdapter.insert(
        friend, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateFriend(FriendsEntity friend) async {
    await _friendsEntityUpdateAdapter.update(
        friend, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteFriend(FriendsEntity friend) async {
    await _friendsEntityDeletionAdapter.delete(friend);
  }
}

class _$LikedMoviesDao extends LikedMoviesDao {
  _$LikedMoviesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _likedMovieEntityInsertionAdapter = InsertionAdapter(
            database,
            'liked_movies',
            (LikedMovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.userId,
                  'movie_id': item.movieId
                }),
        _likedMovieEntityDeletionAdapter = DeletionAdapter(
            database,
            'liked_movies',
            ['id'],
            (LikedMovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.userId,
                  'movie_id': item.movieId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LikedMovieEntity> _likedMovieEntityInsertionAdapter;

  final DeletionAdapter<LikedMovieEntity> _likedMovieEntityDeletionAdapter;

  @override
  Future<List<LikedMovieEntity>> findAllLikedMoviesOf(int userId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM liked_movies WHERE user_id = ?1',
        mapper: (Map<String, Object?> row) => LikedMovieEntity(
            row['id'] as int, row['user_id'] as int, row['movie_id'] as int),
        arguments: [userId]);
  }

  @override
  Future<void> insertLikedMovie(LikedMovieEntity likedMovie) async {
    await _likedMovieEntityInsertionAdapter.insert(
        likedMovie, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteLikedMovie(LikedMovieEntity likedMovie) async {
    await _likedMovieEntityDeletionAdapter.delete(likedMovie);
  }
}
