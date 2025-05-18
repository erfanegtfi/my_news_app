// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $NewsDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $NewsDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $NewsDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<NewsDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorNewsDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $NewsDatabaseBuilderContract databaseBuilder(String name) =>
      _$NewsDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $NewsDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$NewsDatabaseBuilder(null);
}

class _$NewsDatabaseBuilder implements $NewsDatabaseBuilderContract {
  _$NewsDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $NewsDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $NewsDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<NewsDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$NewsDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$NewsDatabase extends NewsDatabase {
  _$NewsDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NewstDao? _newstDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
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
            'CREATE TABLE IF NOT EXISTS `news` (`title` TEXT, `description` TEXT, `urlToImage` TEXT, `publishedAt` TEXT, `content` TEXT, `qu` TEXT, PRIMARY KEY (`title`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NewstDao get newstDao {
    return _newstDaoInstance ??= _$NewstDao(database, changeListener);
  }
}

class _$NewstDao extends NewstDao {
  _$NewstDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _newsDataModelInsertionAdapter = InsertionAdapter(
            database,
            'news',
            (NewsDataModel item) => <String, Object?>{
                  'title': item.title,
                  'description': item.description,
                  'urlToImage': item.urlToImage,
                  'publishedAt': item.publishedAt,
                  'content': item.content,
                  'qu': item.query
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NewsDataModel> _newsDataModelInsertionAdapter;

  @override
  Future<List<NewsDataModel>> getAllNews(
    List<String> queries,
    String fromDate,
    String toDate,
    String sortBy,
  ) async {
    const offset = 4;
    final _sqliteVariablesForQueries =
        Iterable<String>.generate(queries.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'SELECT * FROM news    WHERE qu IN (' +
            _sqliteVariablesForQueries +
            ')   AND publishedAt BETWEEN ?1 AND ?2   ORDER BY      CASE ?3 WHEN \'newest\' THEN publishedAt END DESC,     CASE ?3 WHEN \'oldest\' THEN publishedAt END ASC',
        mapper: (Map<String, Object?> row) => NewsDataModel(title: row['title'] as String?, description: row['description'] as String?, urlToImage: row['urlToImage'] as String?, publishedAt: row['publishedAt'] as String?, content: row['content'] as String?),
        arguments: [fromDate, toDate, sortBy, ...queries]);
  }

  @override
  Stream<List<NewsDataModel>> getAllNewsAsStream(
    List<String> queries,
    String fromDate,
    String toDate,
    String sortBy,
  ) {
    const offset = 4;
    final _sqliteVariablesForQueries =
        Iterable<String>.generate(queries.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryListStream(
        'SELECT * FROM news    WHERE qu IN (' +
            _sqliteVariablesForQueries +
            ')   AND publishedAt BETWEEN ?1 AND ?2   ORDER BY      CASE ?3 WHEN \'newest\' THEN publishedAt END DESC,     CASE ?3 WHEN \'oldest\' THEN publishedAt END ASC',
        mapper: (Map<String, Object?> row) => NewsDataModel(
            title: row['title'] as String?,
            description: row['description'] as String?,
            urlToImage: row['urlToImage'] as String?,
            publishedAt: row['publishedAt'] as String?,
            content: row['content'] as String?),
        arguments: [fromDate, toDate, sortBy, ...queries],
        queryableName: 'news',
        isView: false);
  }

  @override
  Future<void> insertNews(List<NewsDataModel> news) async {
    await _newsDataModelInsertionAdapter.insertList(
        news, OnConflictStrategy.replace);
  }
}
