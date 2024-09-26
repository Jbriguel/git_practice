import 'dart:convert';
import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/modeles/data_commande/habit/habit.dart'; 
import 'package:sqflite/sqflite.dart';
import '../db_config.dart';

extension HabitHelper on DatabaseHelper {
  // Table name
  static const String habitTable = DbConfig.habitTable_name;

  // Ajouter un habit
  Future<int> ajouterHabit(Habit habit) async {
    final db = await database;

    return await db.insert(
      habitTable,
      habit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Remplace en cas de conflit sur uid
    );
  }

  // Modifier un habit
  Future<int?> modifierHabit(Habit habit) async {
    final db = await database;

    return db.update(
      habitTable,
      habit.toMap(),
      where: 'uid = ?',
      whereArgs: [habit.uid],
      conflictAlgorithm: ConflictAlgorithm.ignore, // Ignore en cas de conflit
    );
  }

  // Récupérer un habit spécifique par UID
  Future<Habit?> recupererHabit(String uid) async {
    final db = await database;

    final queryResult = await db.query(
      habitTable,
      where: 'uid = ?',
      whereArgs: [uid],
    );
    return queryResult.isNotEmpty ? Habit.fromMap(queryResult.first) : null;
  }

  // Supprimer un habit
  Future<int> supprimerHabit(String uid) async {
    final db = await database;

    return db.delete(
      habitTable,
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  // Récupérer tous les habits
  Future<List<Habit>> recupererTousLesHabits() async {
    final db = await database;

    final queryResult = await db.query(habitTable);

    return queryResult.map((json) => Habit.fromMap(json)).toList();
  }
}
