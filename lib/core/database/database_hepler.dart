import 'dart:io';

import 'package:atelier_so/core/database/db_config.dart';
import 'package:atelier_so/core/database/db_tables_creator.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, DbConfig.name);

    return await openDatabase(
      path,
      version: DbConfig.version,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON');
    await DbTablesCreator.createUserTable(db);
    await DbTablesCreator.createProprietyTable(db);
    await DbTablesCreator.createModeleTable(db);
    await DbTablesCreator.createModProprietyTable(db);
    await DbTablesCreator.createCommandeTable(db);
    await DbTablesCreator.createHabitTable(db);
    await DbTablesCreator.createHabitProprietyTable(db);
  }

  Future<String> getDbFile() async {
    final db = await database;
    return db.path;
  }
}
