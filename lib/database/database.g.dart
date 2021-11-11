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

  PersonalQueueDao? _personalQueueDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `movie_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `image` TEXT NOT NULL, `MPAA_rating` TEXT NOT NULL, `IMDB_rating` REAL NOT NULL, `runtime` TEXT NOT NULL, `genres` TEXT NOT NULL, `year` INTEGER NOT NULL, `streaming_service` TEXT NOT NULL, `synopsis` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `username` TEXT NOT NULL, `password` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `friends_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `user_one_id` INTEGER NOT NULL, `user_two_id` INTEGER NOT NULL, `pending` INTEGER NOT NULL, FOREIGN KEY (`user_one_id`) REFERENCES `users_table` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`user_two_id`) REFERENCES `users_table` (`id`) ON UPDATE CASCADE ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `liked_movies_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `user_id` INTEGER NOT NULL, `movie_id` INTEGER NOT NULL, FOREIGN KEY (`user_id`) REFERENCES `users_table` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`movie_id`) REFERENCES `movie_table` (`id`) ON UPDATE CASCADE ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `personal_queue_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `user_id` INTEGER NOT NULL, `movie_id` INTEGER NOT NULL, `priority` INTEGER NOT NULL, FOREIGN KEY (`user_id`) REFERENCES `users_table` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`movie_id`) REFERENCES `movie_table` (`id`) ON UPDATE CASCADE ON DELETE CASCADE)');

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

  @override
  PersonalQueueDao get personalQueueDao {
    return _personalQueueDaoInstance ??=
        _$PersonalQueueDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _movieEntityInsertionAdapter = InsertionAdapter(
            database,
            'movie_table',
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'image': item.imageUrl,
                  'MPAA_rating': item.mpaa,
                  'IMDB_rating': item.imdb,
                  'runtime': item.runtime,
                  'genres': item.genres,
                  'year': item.year,
                  'streaming_service': item.streamingService,
                  'synopsis': item.synopsis
                }),
        _movieEntityUpdateAdapter = UpdateAdapter(
            database,
            'movie_table',
            ['id'],
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'image': item.imageUrl,
                  'MPAA_rating': item.mpaa,
                  'IMDB_rating': item.imdb,
                  'runtime': item.runtime,
                  'genres': item.genres,
                  'year': item.year,
                  'streaming_service': item.streamingService,
                  'synopsis': item.synopsis
                }),
        _movieEntityDeletionAdapter = DeletionAdapter(
            database,
            'movie_table',
            ['id'],
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'image': item.imageUrl,
                  'MPAA_rating': item.mpaa,
                  'IMDB_rating': item.imdb,
                  'runtime': item.runtime,
                  'genres': item.genres,
                  'year': item.year,
                  'streaming_service': item.streamingService,
                  'synopsis': item.synopsis
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieEntity> _movieEntityInsertionAdapter;

  final UpdateAdapter<MovieEntity> _movieEntityUpdateAdapter;

  final DeletionAdapter<MovieEntity> _movieEntityDeletionAdapter;

  @override
  Future<List<MovieEntity>> findAllMovies() async {
    return _queryAdapter.queryList('SELECT * FROM movie_table',
        mapper: (Map<String, Object?> row) => MovieEntity(
            row['id'] as int?,
            row['title'] as String,
            row['image'] as String,
            row['MPAA_rating'] as String,
            row['IMDB_rating'] as double,
            row['runtime'] as String,
            row['genres'] as String,
            row['year'] as int,
            row['streaming_service'] as String,
            row['synopsis'] as String));
  }

  @override
  Future<MovieEntity?> findMovieByTitle(String title) async {
    return _queryAdapter.query('SELECT * FROM movie_table WHERE title = ?1',
        mapper: (Map<String, Object?> row) => MovieEntity(
            row['id'] as int?,
            row['title'] as String,
            row['image'] as String,
            row['MPAA_rating'] as String,
            row['IMDB_rating'] as double,
            row['runtime'] as String,
            row['genres'] as String,
            row['year'] as int,
            row['streaming_service'] as String,
            row['synopsis'] as String),
        arguments: [title]);
  }

  @override
  Future<MovieEntity?> findMovieById(int id) async {
    return _queryAdapter.query('SELECT * FROM movie_table WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieEntity(
            row['id'] as int?,
            row['title'] as String,
            row['image'] as String,
            row['MPAA_rating'] as String,
            row['IMDB_rating'] as double,
            row['runtime'] as String,
            row['genres'] as String,
            row['year'] as int,
            row['streaming_service'] as String,
            row['synopsis'] as String),
        arguments: [id]);
  }

  @override
  Future<MovieEntity?> findMovieByIdAndGenre(int id, String genre) async {
    return _queryAdapter.query(
        'SELECT * FROM movie_table WHERE id = ?1 AND genres LIKE ?2',
        mapper: (Map<String, Object?> row) => MovieEntity(
            row['id'] as int?,
            row['title'] as String,
            row['image'] as String,
            row['MPAA_rating'] as String,
            row['IMDB_rating'] as double,
            row['runtime'] as String,
            row['genres'] as String,
            row['year'] as int,
            row['streaming_service'] as String,
            row['synopsis'] as String),
        arguments: [id, genre]);
  }

  @override
  Future<List<MovieEntity>> findMoviesOfGenre(String genre) async {
    return _queryAdapter.queryList(
        'SELECT * FROM movie_table WHERE genres LIKE ?1',
        mapper: (Map<String, Object?> row) => MovieEntity(
            row['id'] as int?,
            row['title'] as String,
            row['image'] as String,
            row['MPAA_rating'] as String,
            row['IMDB_rating'] as double,
            row['runtime'] as String,
            row['genres'] as String,
            row['year'] as int,
            row['streaming_service'] as String,
            row['synopsis'] as String),
        arguments: [genre]);
  }

  @override
  Future<void> clearMovieTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM movie_table');
  }

  @override
  Future<int> insertMovie(MovieEntity movie) {
    return _movieEntityInsertionAdapter.insertAndReturnId(
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
      : _queryAdapter = QueryAdapter(database),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'users_table',
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'username': item.userName,
                  'password': item.password
                }),
        _userEntityUpdateAdapter = UpdateAdapter(
            database,
            'users_table',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'username': item.userName,
                  'password': item.password
                }),
        _userEntityDeletionAdapter = DeletionAdapter(
            database,
            'users_table',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'username': item.userName,
                  'password': item.password
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  final UpdateAdapter<UserEntity> _userEntityUpdateAdapter;

  final DeletionAdapter<UserEntity> _userEntityDeletionAdapter;

  @override
  Future<List<UserEntity>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM users_table',
        mapper: (Map<String, Object?> row) => UserEntity(
            row['id'] as int?,
            row['name'] as String,
            row['username'] as String,
            row['password'] as String));
  }

  @override
  Future<UserEntity?> findUserByUsername(String userName) async {
    return _queryAdapter.query('SELECT * FROM users_table WHERE username = ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            row['id'] as int?,
            row['name'] as String,
            row['username'] as String,
            row['password'] as String),
        arguments: [userName]);
  }

  @override
  Future<UserEntity?> findUserByUsernameAndPass(
      String userName, String pass) async {
    return _queryAdapter.query(
        'SELECT * FROM users_table WHERE username = ?1 AND password = ?2',
        mapper: (Map<String, Object?> row) => UserEntity(
            row['id'] as int?,
            row['name'] as String,
            row['username'] as String,
            row['password'] as String),
        arguments: [userName, pass]);
  }

  @override
  Future<UserEntity?> findUserById(int id) async {
    return _queryAdapter.query('SELECT * FROM users_table WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            row['id'] as int?,
            row['name'] as String,
            row['username'] as String,
            row['password'] as String),
        arguments: [id]);
  }

  @override
  Future<void> clearUserTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM users_table');
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
      : _queryAdapter = QueryAdapter(database, changeListener),
        _friendsEntityInsertionAdapter = InsertionAdapter(
            database,
            'friends_table',
            (FriendsEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_one_id': item.userOneId,
                  'user_two_id': item.userTwoId,
                  'pending': item.pending ? 1 : 0
                },
            changeListener),
        _friendsEntityUpdateAdapter = UpdateAdapter(
            database,
            'friends_table',
            ['id'],
            (FriendsEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_one_id': item.userOneId,
                  'user_two_id': item.userTwoId,
                  'pending': item.pending ? 1 : 0
                },
            changeListener),
        _friendsEntityDeletionAdapter = DeletionAdapter(
            database,
            'friends_table',
            ['id'],
            (FriendsEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_one_id': item.userOneId,
                  'user_two_id': item.userTwoId,
                  'pending': item.pending ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FriendsEntity> _friendsEntityInsertionAdapter;

  final UpdateAdapter<FriendsEntity> _friendsEntityUpdateAdapter;

  final DeletionAdapter<FriendsEntity> _friendsEntityDeletionAdapter;

  @override
  Future<List<FriendsEntity>> findAllFriendsOf(int userId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM friends_table WHERE (user_one_id = ?1 OR user_two_id = ?1) AND pending = 0',
        mapper: (Map<String, Object?> row) => FriendsEntity(row['id'] as int?, row['user_one_id'] as int, row['user_two_id'] as int, (row['pending'] as int) != 0),
        arguments: [userId]);
  }

  @override
  Stream<List<FriendsEntity>> findAllFriendsOfUserAsStream(int userId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM friends_table WHERE (user_one_id = ?1 OR user_two_id = ?1) AND pending = 0',
        mapper: (Map<String, Object?> row) => FriendsEntity(
            row['id'] as int?,
            row['user_one_id'] as int,
            row['user_two_id'] as int,
            (row['pending'] as int) != 0),
        arguments: [userId],
        queryableName: 'friends_table',
        isView: false);
  }

  @override
  Future<List<FriendsEntity>> findAllPendingFriendsOf(int userId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM friends_table WHERE (user_one_id = ?1 OR user_two_id = ?1) AND pending = 1',
        mapper: (Map<String, Object?> row) => FriendsEntity(row['id'] as int?, row['user_one_id'] as int, row['user_two_id'] as int, (row['pending'] as int) != 0),
        arguments: [userId]);
  }

  @override
  Stream<List<FriendsEntity>> findAllPendingFriendsOfUserAsStream(int userId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM friends_table WHERE (user_one_id = ?1 OR user_two_id = ?1) AND pending = 1',
        mapper: (Map<String, Object?> row) => FriendsEntity(
            row['id'] as int?,
            row['user_one_id'] as int,
            row['user_two_id'] as int,
            (row['pending'] as int) != 0),
        arguments: [userId],
        queryableName: 'friends_table',
        isView: false);
  }

  @override
  Future<FriendsEntity?> findFriendOfUser(int userId, int friendId) async {
    return _queryAdapter.query(
        'SELECT * FROM friends_table WHERE (user_one_id = ?1 AND user_two_id = ?2) OR (user_one_id = ?2 AND user_two_id = ?1)',
        mapper: (Map<String, Object?> row) => FriendsEntity(row['id'] as int?, row['user_one_id'] as int, row['user_two_id'] as int, (row['pending'] as int) != 0),
        arguments: [userId, friendId]);
  }

  @override
  Future<void> deleteAllFriendsOfUser(int userId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM friends_table WHERE user_one_id = ?1 OR user_two_id = ?1',
        arguments: [userId]);
  }

  @override
  Future<void> clearFriendsTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM friends_table');
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
      : _queryAdapter = QueryAdapter(database, changeListener),
        _likedMovieEntityInsertionAdapter = InsertionAdapter(
            database,
            'liked_movies_table',
            (LikedMovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.userId,
                  'movie_id': item.movieId
                },
            changeListener),
        _likedMovieEntityDeletionAdapter = DeletionAdapter(
            database,
            'liked_movies_table',
            ['id'],
            (LikedMovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.userId,
                  'movie_id': item.movieId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LikedMovieEntity> _likedMovieEntityInsertionAdapter;

  final DeletionAdapter<LikedMovieEntity> _likedMovieEntityDeletionAdapter;

  @override
  Future<List<LikedMovieEntity>> findAllLikedMoviesOf(int userId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM liked_movies_table WHERE user_id = ?1',
        mapper: (Map<String, Object?> row) => LikedMovieEntity(
            row['id'] as int?, row['user_id'] as int, row['movie_id'] as int),
        arguments: [userId]);
  }

  @override
  Stream<List<LikedMovieEntity>> findAllLikedMoviesOfUserAsStream(int userId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM liked_movies_table WHERE user_id = ?1',
        mapper: (Map<String, Object?> row) => LikedMovieEntity(
            row['id'] as int?, row['user_id'] as int, row['movie_id'] as int),
        arguments: [userId],
        queryableName: 'liked_movies_table',
        isView: false);
  }

  @override
  Future<LikedMovieEntity?> findLikedMovie(int userId, int movieId) async {
    return _queryAdapter.query(
        'SELECT * FROM liked_movies_table WHERE user_id = ?1 AND movie_id = ?2',
        mapper: (Map<String, Object?> row) => LikedMovieEntity(
            row['id'] as int?, row['user_id'] as int, row['movie_id'] as int),
        arguments: [userId, movieId]);
  }

  @override
  Future<void> deleteAllLikedMoviesFromUser(int userId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM liked_movies_table WHERE user_id = ?1',
        arguments: [userId]);
  }

  @override
  Future<void> clearLikedMovieTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM liked_movies_table');
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

class _$PersonalQueueDao extends PersonalQueueDao {
  _$PersonalQueueDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _personalQueueEntityInsertionAdapter = InsertionAdapter(
            database,
            'personal_queue_table',
            (PersonalQueueEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.userId,
                  'movie_id': item.movieId,
                  'priority': item.priority
                },
            changeListener),
        _personalQueueEntityUpdateAdapter = UpdateAdapter(
            database,
            'personal_queue_table',
            ['id'],
            (PersonalQueueEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.userId,
                  'movie_id': item.movieId,
                  'priority': item.priority
                },
            changeListener),
        _personalQueueEntityDeletionAdapter = DeletionAdapter(
            database,
            'personal_queue_table',
            ['id'],
            (PersonalQueueEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.userId,
                  'movie_id': item.movieId,
                  'priority': item.priority
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PersonalQueueEntity>
      _personalQueueEntityInsertionAdapter;

  final UpdateAdapter<PersonalQueueEntity> _personalQueueEntityUpdateAdapter;

  final DeletionAdapter<PersonalQueueEntity>
      _personalQueueEntityDeletionAdapter;

  @override
  Future<List<PersonalQueueEntity>> findAllPersonalQueueMovies(
      int userId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM personal_queue_table WHERE user_id = ?1 ORDER BY priority',
        mapper: (Map<String, Object?> row) => PersonalQueueEntity(row['id'] as int?, row['user_id'] as int, row['movie_id'] as int, row['priority'] as int),
        arguments: [userId]);
  }

  @override
  Stream<List<PersonalQueueEntity>> findAllPersonalQueueMoviesAsStream(
      int userId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM personal_queue_table WHERE user_id = ?1 ORDER BY priority',
        mapper: (Map<String, Object?> row) => PersonalQueueEntity(
            row['id'] as int?,
            row['user_id'] as int,
            row['movie_id'] as int,
            row['priority'] as int),
        arguments: [userId],
        queryableName: 'personal_queue_table',
        isView: false);
  }

  @override
  Future<PersonalQueueEntity?> findPersonalQueueMovie(
      int userId, int movieId) async {
    return _queryAdapter.query(
        'SELECT * FROM personal_queue_tabLE WHERE user_id = ?1 AND movie_id = ?2',
        mapper: (Map<String, Object?> row) => PersonalQueueEntity(row['id'] as int?, row['user_id'] as int, row['movie_id'] as int, row['priority'] as int),
        arguments: [userId, movieId]);
  }

  @override
  Future<void> clearPersonalQueueMovieTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM personal_queue_table');
  }

  @override
  Future<void> insertPersonalQueueMovie(PersonalQueueEntity movie) async {
    await _personalQueueEntityInsertionAdapter.insert(
        movie, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertPersonalQueueListOfMovies(
      List<PersonalQueueEntity> movies) async {
    await _personalQueueEntityInsertionAdapter.insertList(
        movies, OnConflictStrategy.replace);
  }

  @override
  Future<void> updatePersonalQueueMovie(PersonalQueueEntity movie) async {
    await _personalQueueEntityUpdateAdapter.update(
        movie, OnConflictStrategy.replace);
  }

  @override
  Future<void> deletePersonalQueueMovie(PersonalQueueEntity movie) async {
    await _personalQueueEntityDeletionAdapter.delete(movie);
  }
}
