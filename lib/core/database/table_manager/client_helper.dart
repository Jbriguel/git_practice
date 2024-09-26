import 'dart:convert';

import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/modeles/client/client.dart';
import 'package:sqflite/sqflite.dart';

import '../db_config.dart';

extension ClientHelper on DatabaseHelper {
  //Table name
  static const String clientTable = DbConfig.clientTable_name;
  // Méthode pour ajouter plusieurs clients
  Future<int> ajouterClients(List<Client> clients) async {
    final db = await database;

    // Démarrer une transaction
    return await db.transaction((txn) async {
      int count = 0;

      // Parcourir tous les clients et les insérer dans la base de données
      for (var client in clients) {
        await txn.insert(
          clientTable,
          client.toMap(),
          conflictAlgorithm:
              ConflictAlgorithm.replace, // Remplace en cas de conflit sur uid
        );
        count++; // Incrémenter le nombre de clients insérés
      }

      return count; // Retourner le nombre de clients insérés
    });
  }

  // Future<int> ajouterClients(List<Client> clients) async {
  //   final db = await database;
  //   Batch batch = db.batch();
  //   for (var client in clients) {
  //     batch.insert(
  //       clientTable,
  //       client.toMap(),
  //       conflictAlgorithm:
  //           ConflictAlgorithm.replace, // Remplace en cas de conflit sur uid
  //     );
  //   }
  //   List<Object?> result = await batch.commit();
  //   return result.length;
  // }

  // Méthode pour modifier un client
  Future<int?> modifierClient(Client client) async {
    final db = await database;
    return db.update(
      clientTable,
      client.toJson(),
      where: 'uid = ?',
      whereArgs: [client.uid],
      conflictAlgorithm:
          ConflictAlgorithm.ignore, // Ignore le conflit en cas de modification
    );
  }

  // Méthode pour sélectionner un client spécifique par UID
  Future<Client?> selectionnerClient(String uid) async {
    final db = await database;
    final queryResult = await db.query(
      clientTable,
      where: 'uid = ?',
      whereArgs: [uid],
    );
    return queryResult.isNotEmpty ? Client.fromMap(queryResult.first) : null;
  }

  // Méthode pour supprimer un client par UID
  // Future<int> supprimerClient(String uid) async {
  //   final db = await database;
  //   return db.delete(
  //     clientTable,
  //     where: 'uid = ?',
  //     whereArgs: [uid],
  //   );
  // }

  Future<int?> supprimerClient(String uid) async {
    final db = await database;
    Client? client = await selectionnerClient(uid);

    if (client != null) {
      // Mettez à jour isDeleted à 1 pour marquer comme supprimé
      final updatedClient = client.rebuild((b) => b
        ..isDeleted = 1 // Utiliser 1 pour true
        ..updatedAt = DateTime.now().toUtc());
      // ..updatedAt = DateTime.now().toIso8601String());

      return await modifierClient(updatedClient);
    }
    return 0;
  }

  // Méthode pour obtenir tous les clients
  Future<List<Client>> obtenirTousLesClients() async {
    final db = await database;
    final queryResult = await db.query(
      clientTable,
      where: 'isDeleted = 0',
    );
    return queryResult.map((json) => Client.fromMap(json)).toList();
  }

  Future<void> recupererBaseDeDonnees() async {
    // final ref = FirebaseStorage.instance.ref().child('sauvegardes').child('clients.json');
    // final fileContent = await ref.getString();
    // final List<dynamic> jsonData = jsonDecode(fileContent);

    // for (var item in jsonData) {
    //   Client client = Client.fromJson(item);
    //   await ajouterOuMettreAJourClient(client);
    // }
  }

  Future<void> ajouterOuMettreAJourClient(Client client) async {
    final db = await database;
    final existingClient = await selectionnerClient(client.uid!);

    if (existingClient == null ||
        client.updatedAt.isAfter(existingClient.updatedAt)) {
      if (client.isDeleted == 1) {
        // Vérifiez avec 1 pour true
        await supprimerClient(client.uid!);
      } else {
        await modifierClient(client);
      }
    }
  }

  Future<void> sauvegarderBaseDeDonnees() async {
    // final db = await database;
    // final queryResult = await db.query('clients');
    // final jsonData = queryResult.map((json) => Client.fromJson(json)).toList();
    // final fileContent = jsonEncode(jsonData);

    // final ref = FirebaseStorage.instance.ref().child('sauvegardes').child('clients.json');
    // await ref.putString(fileContent);
  }
}
