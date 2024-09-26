import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/modeles/data_commande/habit_propriety/habit_propriety.dart';
import 'package:sqflite/sqflite.dart';
import '../db_config.dart';

extension HabitProprietyHelper on DatabaseHelper {
  // Table name
  static const String habitProprietyTable = DbConfig.habitProprietyTable_name;

  // Ajouter une propriété à un habit

  Future<int> ajouterHabitPropriety(HabitPropriety habitPropriety) async {
    final db = await database;

    return await db.insert(
      habitProprietyTable,
      habitPropriety.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Remplace en cas de conflit sur uid
    );
  }

  // Modifier une propriété d'un habit
  Future<int?> modifierHabitPropriety(HabitPropriety habitPropriety) async {
    final db = await database;

    return db.update(
      habitProprietyTable,
      habitPropriety.toMap(),
      where: 'habitUid = ? AND name = ?',
      whereArgs: [habitPropriety.habitUid, habitPropriety.name],
      conflictAlgorithm: ConflictAlgorithm.ignore, // Ignore en cas de conflit
    );
  }

  // Récupérer les propriétés associées à un habit
  Future<List<HabitPropriety>> recupererProprietesHabit(String habitUid) async {
    final db = await database;

    final queryResult = await db.query(
      habitProprietyTable,
      where: 'habitUid = ?',
      whereArgs: [habitUid],
    );
    return queryResult.map((json) => HabitPropriety.fromMap(json)).toList();
  }

  // Supprimer une propriété d'un habit
  Future<int> supprimerHabitPropriety(String habitUid, String name) async {
    final db = await database;

    return db.delete(
      habitProprietyTable,
      where: 'habitUid = ? AND name = ?',
      whereArgs: [habitUid, name],
    );
  }

  // Supprimer toutes les propriétés associées à un habit
  Future<int> supprimerToutesLesProprietesHabit(String habitUid) async {
    final db = await database;

    return db.delete(
      habitProprietyTable,
      where: 'habitUid = ?',
      whereArgs: [habitUid],
    );
  }
}
