import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:vtracker/features/auth/data/models/multi_login_models.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblAccountlist = 'accountlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();

    final databasePath = '$path/vtracker.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS  $_tblAccountlist (
        image TEXT,
        name TEXT,
        tag TEXT,
        username TEXT,
        password TEXT
      );
    ''');
  }

  Future<int> insertAccountList(AccountLogin account) async {
    final db = await database;

    final results = await db!.query(
      _tblAccountlist,
      where: 'username = ?',
      whereArgs: [account.username],
    );

    if (results.isEmpty) {
      return await db.insert(
        _tblAccountlist,
        account.toJson(),
      );
    } else {
      return await db.update(
        _tblAccountlist,
        account.toJson(),
      );
    }
  }

  Future<int> removeAccountList(AccountLogin account) async {
    final db = await database;
    return await db!.delete(
      _tblAccountlist,
      where: 'username = ?',
      whereArgs: [account.username],
    );
  }

  Future<List<Map<String, dynamic>>> getAccountList() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblAccountlist);
    return results;
  }
}
