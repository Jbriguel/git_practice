import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/db_config.dart';
import 'package:atelier_so/core/modeles/data_modeles/modele_propriety/mod_propriety.dart';
import 'package:sqflite/sqflite.dart';

extension ModProprietyHelper on DatabaseHelper {
  static const String modProprietyTable = DbConfig
      .modProprietyTable_name; // Assurez-vous de remplacer par le nom de table correct

  Future<List<ModPropriety>> obtenirProprietiesParModele(
      String modeleUid) async {
    final db = await database;
    final queryResult = await db.query(
      modProprietyTable,
      where: 'modeleUid = ?',
      whereArgs: [modeleUid],
    );

    return queryResult.map((data) => ModPropriety.fromJson(data)).toList();
  }

  Future<int> ajouterModPropriety(ModPropriety modPropriety) async {
    final db = await database;
    return await db.insert(
      modProprietyTable,
      modPropriety.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int?> modifierModPropriety(ModPropriety modPropriety) async {
    final db = await database;
    return db.update(
      modProprietyTable,
      modPropriety.toJson(),
      where: 'uid = ?',
      whereArgs: [modPropriety.uid],
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<ModPropriety?> selectionnerModPropriety(String uid) async {
    final db = await database;
    final queryResult = await db.query(
      modProprietyTable,
      where: 'uid = ?',
      whereArgs: [uid],
    );
    return queryResult.isNotEmpty
        ? ModPropriety.fromJson(queryResult.first)
        : null;
  }

  Future<int?> supprimerModPropriety(String uid) async {
    final db = await database;
    return db.delete(
      modProprietyTable,
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }
}
