import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/db_config.dart';
import 'package:atelier_so/core/modeles/data_modeles/propriety/propriety.dart';
import 'package:sqflite/sqflite.dart';

extension ProprietyHelper on DatabaseHelper {
  static const String proprietyTable = DbConfig
      .proprietyTable_name; // Assurez-vous de remplacer par le nom de table correct

  // Create a new propriety
  Future<int> createPropriety(Propriety propriety) async {
    final db = await database;
    return await db.insert(
      proprietyTable,
      propriety.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get a single propriety by uid
  Future<Propriety?> getPropriety(String uid) async {
    final db = await database;
    final maps = await db.query(
      proprietyTable,
      where: 'uid = ?',
      whereArgs: [uid],
    );

    if (maps.isNotEmpty) {
      return Propriety.fromJson(maps.first);
    } else {
      return null; // Aucune propriété trouvée avec cet UID
    }
  }

  // Get all proprieties
  Future<List<Propriety>> getAllProprieties() async {
    final db = await database;
    final result = await db.query(proprietyTable);

    return result.map((json) => Propriety.fromJson(json)).toList();
  }

  // Update an existing propriety
  Future<int> updatePropriety(Propriety propriety) async {
    final db = await database;
    return await db.update(
      proprietyTable,
      propriety.toJson(),
      where: 'uid = ?',
      whereArgs: [propriety.uid],
    );
  }

  // Delete a propriety by uid
  Future<int> deletePropriety(String uid) async {
    final db = await database;
    return await db.delete(
      proprietyTable,
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  // Delete all proprieties
  Future<void> deleteAllProprieties() async {
    final db = await database;
    await db.delete(proprietyTable);
  }
}
