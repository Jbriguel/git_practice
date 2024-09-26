import 'dart:io';

import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/db_config.dart';
import 'package:atelier_so/core/functions/utiles_functions.dart';
import 'package:atelier_so/core/repository/fileRepository/file_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert'; // Pour encoder en JSON

@singleton
class DbExportRepository {
  ContextDistributor _contextDistributor;
  DatabaseHelper _databaseHelper;
  FileRepository _fileRepository;

  DbExportRepository(
      this._contextDistributor, this._databaseHelper, this._fileRepository);

  Future<Database> get database async {
    return _databaseHelper.database;
  }

  Future<Map<String, dynamic>> _getTableData(String tableName) async {
    Database db = await _databaseHelper.database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    return {
      tableName: result,
    };
  }

  Future<Map<String, dynamic>> exportDatabaseToJson({
    required String entrepriseId,
    required String creatorId,
    required String backupUid,
  }) async {
    // Récupération des données de toutes les tables
    final Map<String, dynamic> clientTableData =
        await _getTableData(DbConfig.clientTable_name);
    final Map<String, dynamic> modeleTableData =
        await _getTableData(DbConfig.modeleTable_name);
    final Map<String, dynamic> modProprietyTableData =
        await _getTableData(DbConfig.modProprietyTable_name);
    final Map<String, dynamic> proprietyTableData =
        await _getTableData(DbConfig.proprietyTable_name);
    final Map<String, dynamic> commandeTableData =
        await _getTableData(DbConfig.commandeTable_name);
    final Map<String, dynamic> habitTableData =
        await _getTableData(DbConfig.habitTable_name);
    final Map<String, dynamic> habitProprietyTableData =
        await _getTableData(DbConfig.habitProprietyTable_name);

    // Ajout de métadonnées
    final Map<String, dynamic> metadata = {
      'backupUid': backupUid, // UID unique de la sauvegarde
      'entrepriseId': entrepriseId, // ID de l'entreprise
      'creatorId': creatorId, // ID de celui qui a fait la sauvegarde
      'createdAt':
          DateTime.now().toIso8601String(), // Date de création de la sauvegarde
      'updatedAt': DateTime.now()
          .toIso8601String(), // Date de mise à jour de la sauvegarde
    };

    // Compilation de toutes les données dans un seul objet JSON
    final Map<String, dynamic> databaseJson = {
      'metadata': metadata,
      'data': {
        'clients': clientTableData[DbConfig.clientTable_name],
        'modeles': modeleTableData[DbConfig.modeleTable_name],
        'modProprieties':
            modProprietyTableData[DbConfig.modProprietyTable_name],
        'proprieties': proprietyTableData[DbConfig.proprietyTable_name],
        'commandes': commandeTableData[DbConfig.commandeTable_name],
        'habits': habitTableData[DbConfig.habitTable_name],
        'habitProprieties':
            habitProprietyTableData[DbConfig.habitProprietyTable_name],
      },
    };

    return databaseJson;
  }

  Future<File> createTempJsonFile(
      Map<String, dynamic> jsonData, String fileName) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/$fileName.json';
    final file = File(path);

    // Convertir les données JSON en chaîne de caractères
    final jsonString = jsonEncode(jsonData);

    // Écrire les données dans le fichier
    return file.writeAsString(jsonString);
  }

  Future<String?> uploadJsonToFirebase(
      String metaInfo,
      String type,
      String savePath,
      String saveName,
      void Function(String value) setMessage) async {
    // Informations nécessaires pour la sauvegarde
    String entrepriseId = "12345"; // Remplacez par l'ID de l'entreprise réelle
    String creatorId = "67890"; // Remplacez par l'ID du créateur réel
    String backupUid = "backup_001"; // UID unique de la sauvegarde

    // Exporter la base de données en JSON
    Map<String, dynamic> databaseJson = await exportDatabaseToJson(
      entrepriseId: entrepriseId,
      creatorId: creatorId,
      backupUid: backupUid,
    );
    // Créer un fichier temporaire contenant le JSON
    File jsonFile = await createTempJsonFile(databaseJson, saveName);

    // Envoyer le fichier dans Firebase Storage en utilisant la fonction `fileUploader`
    String? downloadUrl = await fileUploader(setMessage,
        file: jsonFile,
        metaInfo: metaInfo,
        type: type,
        savePath: savePath,
        saveName: saveName);

    // Supprimer le fichier temporaire après l'envoi
    await jsonFile.delete();

    return downloadUrl;
  }

  // Optionnel: Sauvegarde du JSON dans un fichier (si besoin)
  Future<void> saveBackupToFile(
      String filePath, Map<String, dynamic> jsonData) async {
    final String jsonString = jsonEncode(jsonData);
    // Vous pouvez utiliser des APIs de fichiers comme path_provider pour stocker le fichier localement
    // Par exemple, File(filePath).writeAsString(jsonString);
  }
}
