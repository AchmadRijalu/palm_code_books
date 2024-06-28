import 'dart:convert';

import 'package:palm_code_books/models/book_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  //Database Key
  static const String _bookKey = "book";

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase("$path/bookapp.db", onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE $_bookKey(
        id INTEGER PRIMARY KEY, 
        title TEXT, 
        authors TEXT, 
        translators TEXT, 
        subjects TEXT, 
        bookshelves TEXT, 
        languages TEXT, 
        copyright INTEGER, 
        mediaType TEXT, 
        formats TEXT, 
        downloadCount INTEGER
      )
    ''');
    }, version: 1);
    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<void> insertBook(Result result) async {
    final db = await database;
    if (db == null) {
      throw Exception("Database is not initialized");
    }

    await db.insert(
      _bookKey,
      {
        'id': result.id,
        'title': result.title,
        'authors': jsonEncode(
            result.authors.map((author) => author.toJson()).toList()),
        'translators': jsonEncode(result.translators
            .map((translator) => translator.toJson())
            .toList()),
        'subjects': jsonEncode(result.subjects),
        'bookshelves': jsonEncode(result.bookshelves),
        'languages': jsonEncode(
            result.languages.map((language) => language.toString()).toList()),
        'copyright': result.copyright ? 1 : 0,
        'mediaType': result.mediaType.toString(),
        'formats': jsonEncode(result.formats?.toJson()),
        'downloadCount': result.downloadCount,
      },
    );
  }

  Future<List<Result>> getBooks() async {
    final db = await database;
    if (db == null) {
      throw Exception("Database is not initialized");
    }
    List<Map<String, dynamic>> results = await db.query(_bookKey);
    return results.map((res) => Result.fromDatabaseJson(res)).toList();
  }

  Future<Map> getBookById(int id) async {
    final db = await database;

    List<Map<String, dynamic>> results =
        await db!.query(_bookKey, where: 'id = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }
  
  Future<void> removeBook(int id) async {
    final db = await database;

    await db!.delete(_bookKey, where: 'id = ?', whereArgs: [id]);
  }
}
