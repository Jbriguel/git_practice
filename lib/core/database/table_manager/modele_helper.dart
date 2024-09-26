import 'dart:developer';

import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/db_config.dart';
import 'package:atelier_so/core/modeles/data_modeles/modele/modele.dart';
import 'package:atelier_so/core/modeles/data_modeles/modele_propriety/mod_propriety.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../modeles/data_modeles/propriety/propriety.dart';

extension ModeleHelper on DatabaseHelper {
  static const String modeleTable = DbConfig.modeleTable_name;
  static const String modProprietyTable = DbConfig.modProprietyTable_name;
  static const String proprietyTable = DbConfig.proprietyTable_name;

  Future<void> ajouterModeleAvecProprietes(
      Modele modele, List<Propriety> proprietes) async {
    final db = await database;

    // Démarrer une transaction pour s'assurer que tout est inséré correctement
    await db.transaction((txn) async {
      final modeleMap = modele.toJson();
      modeleMap.remove('proprieties'); // Supprimer la liste des propriétés

      // Insérer le Modele
      await txn.insert(
        DbConfig.modeleTable_name,
        modeleMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Insérer les Proprieties et les lier au Modele
      for (var propriete in proprietes) {
        // Vérifier si la propriété existe déjà
        final proprieteExistante = await txn.query(
          DbConfig.proprietyTable_name,
          where: 'name = ?',
          whereArgs: [propriete.name],
        );

        // Insérer la propriété seulement si elle n'existe pas
        if (proprieteExistante.isEmpty) {
          await txn.insert(
            DbConfig.proprietyTable_name,
            propriete.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        // // Insérer la Propriety
        // await txn.insert(
        //   DbConfig.proprietyTable_name,
        //   propriete.toJson(),
        //   conflictAlgorithm: ConflictAlgorithm.replace,
        // );

        // Lier la Propriety au Modele
        final modPropriety = ModPropriety((b) => b
          ..uid = const Uuid().v4()
          //UniqueKey().toString() // Générer un UID unique pour la liaison
          ..modeleUid = modele.uid
          ..proprietyUid = propriete.uid);

        await txn.insert(
          DbConfig.modProprietyTable_name,
          modPropriety.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<Modele?> recupererModeleAvecProprietes(String modeleUid) async {
    final db = await database;

    // Récupérer le modèle à partir de son UID
    final modeleData = await db.query(
      DbConfig.modeleTable_name,
      where: 'uid = ?',
      whereArgs: [modeleUid],
    );

    if (modeleData.isNotEmpty) {
      // Convertir les données du modèle en objet Modele
      final modele = Modele.fromJson(modeleData.first);

      // Récupérer les propriétés associées au modèle
      final proprietyData = await db.rawQuery('''
      SELECT p.* FROM ${DbConfig.proprietyTable_name} p
      INNER JOIN ${DbConfig.modProprietyTable_name} mp
      ON p.uid = mp.proprietyUid
      WHERE mp.modeleUid = ?
    ''', [modeleUid]);

      // Convertir les données en objets Propriety
      final proprieties =
          proprietyData.map((data) => Propriety.fromJson(data)).toList();

      // Retourner le modèle avec les propriétés
      return modele.rebuild((b) => b..proprieties.replace(proprieties));
    }

    return null; // Si le modèle n'est pas trouvé
  }

  Future<Modele?> obtenirModeleAvecProprietes(String modeleUid) async {
    final db = await database;

    // Requête pour récupérer le modèle et ses propriétés
    final queryResult = await db.rawQuery('''
    SELECT * FROM ${DbConfig.modeleTable_name} m
    LEFT JOIN ${DbConfig.modProprietyTable_name} mp ON m.uid = mp.modeleUid
    LEFT JOIN ${DbConfig.proprietyTable_name} p ON mp.proprietyUid = p.uid
    WHERE m.uid = ?
  ''', [modeleUid]);

    if (queryResult.isNotEmpty) {
      // Extraire les données du modèle
      final modeleData = queryResult.first;
      final Modele modele = Modele.fromJson(modeleData);

      // Extraire les propriétés associées
      final List<Propriety> proprietes =
          queryResult.map((row) => Propriety.fromJson(row)).toList();

      return modele.rebuild((b) => b..proprieties.replace(proprietes));
    }

    return null;
  }

  Future<void> modifierModeleAvecProprietes(
      Modele modele, List<Propriety> nouvellesProprietes) async {
    final db = await database;
    final modeleMap = modele.toJson();
    modeleMap.remove('proprieties'); // Supprimer la liste des propriétés

    // Démarrer une transaction
    await db.transaction((txn) async {
      // 1. Mettre à jour le Modele
      await txn.update(
        DbConfig.modeleTable_name,
        modeleMap,
        where: 'uid = ?',
        whereArgs: [modele.uid],
      );

      // 2. Récupérer les anciennes propriétés associées au modèle
      final List<Map<String, dynamic>> modelesOldPropriety = await txn.query(
        DbConfig.modProprietyTable_name,
        where: 'modeleUid = ?',
        whereArgs: [modele.uid],
      );

      // Convertir les anciennes propriétés en une liste de UIDs pour une vérification rapide
      final Set<String> oldProprietyUids = modelesOldPropriety
          .map((oldData) => oldData['proprietyUid'] as String)
          .toSet();

      // 3. Récupérer toutes les propriétés existantes
      final List<Map<String, dynamic>> existingProprieties =
          await txn.query(DbConfig.proprietyTable_name);
      final Set<String> existingProprietyNames =
          existingProprieties.map((e) => e['name'] as String).toSet();

      // 4. Ajouter les nouvelles propriétés associées (si elles n'existent pas déjà)
      for (var propriete in nouvellesProprietes) {
        // Si la propriété n'existe pas encore dans la base de données, l'ajouter
        if (!existingProprietyNames.contains(propriete.name)) {
          await txn.insert(
            DbConfig.proprietyTable_name,
            propriete.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }

        // Si la propriété n'est pas déjà associée au modèle, l'ajouter
        if (!oldProprietyUids.contains(propriete.uid)) {
          final modPropriety = ModPropriety((b) => b
            ..uid = UniqueKey().toString()
            ..modeleUid = modele.uid
            ..proprietyUid = propriete.uid);

          await txn.insert(
            DbConfig.modProprietyTable_name,
            modPropriety.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      // 5. Supprimer les propriétés qui ont été désélectionnées
      for (var oldData in modelesOldPropriety) {
        ModPropriety oldPropriety = ModPropriety.fromJson(oldData);
        bool encorePresent = nouvellesProprietes
            .any((prop) => prop.uid == oldPropriety.proprietyUid);

        if (!encorePresent) {
          // Supprimer l'ancienne propriété associée
          await txn.delete(
            DbConfig.modProprietyTable_name,
            where: 'proprietyUid = ? AND modeleUid = ?',
            whereArgs: [oldPropriety.proprietyUid, modele.uid],
          );
        }
      }
    });
  }

  // Future<void> modifierModeleAvecProprietes(
  //     Modele modele, List<Propriety> nouvellesProprietes) async {
  //   final db = await database;
  //   final modeleMap = modele.toJson();
  //   modeleMap.remove(
  //       'proprieties'); // Supprimer la liste des propriétés // Supprimer la liste des propriétés
  //   // Démarrer une transaction
  //   await db.transaction((txn) async {
  //     // Mettre à jour le Modele
  //     await txn.update(
  //       DbConfig.modeleTable_name,
  //       modeleMap,
  //       where: 'uid = ?',
  //       whereArgs: [modele.uid],
  //     );

  //     //Recuperer les anciennes proprietés liées au modele
  //     final List<Map<String, dynamic>> modelesOldPropriety = await txn.query(
  //       DbConfig.modProprietyTable_name,
  //       where: 'modeleUid = ?',
  //       whereArgs: [modele.uid],
  //     );

  //     // Ajouter les nouvelles propriétés
  //     for (var propriete in nouvellesProprietes) {
  //       // Vérifier si la propriété existe déjà
  //       final proprieteExistante = await txn.query(
  //         DbConfig.proprietyTable_name,
  //         where: 'name = ?',
  //         whereArgs: [propriete.name],
  //       );

  //       // Insérer la propriété seulement si elle n'existe pas
  //       if (proprieteExistante.isEmpty) {
  //         //Inserer si  elle n'existe pas
  //         await txn.insert(
  //           DbConfig.proprietyTable_name,
  //           propriete.toJson(),
  //           conflictAlgorithm: ConflictAlgorithm.replace,
  //         );

  //         //Au cas où elle  vient d'être ajouter

  //         final modPropriety = ModPropriety((b) => b
  //           ..uid = UniqueKey().toString()
  //           ..modeleUid = modele.uid
  //           ..proprietyUid = propriete.uid);

  //         await txn.insert(
  //           DbConfig.modProprietyTable_name,
  //           modPropriety.toJson(),
  //           conflictAlgorithm: ConflictAlgorithm.replace,
  //         );
  //       }
  //     }

  //     for (var oldData in modelesOldPropriety) {
  //       ModPropriety oldPropriety = ModPropriety.fromJson(oldData);
  //       bool encorePresent = nouvellesProprietes
  //           .any((prop) => prop.uid == oldPropriety.proprietyUid);
  //       if (!encorePresent) {
  //         // Supprimer l'anciennes propriété associée
  //         await txn.delete(
  //           DbConfig.modProprietyTable_name,
  //           where: 'proprietyUid = ?',
  //           whereArgs: [oldPropriety.uid],
  //         );
  //       }
  //     }
  //   });
  // }

  // Future<void> modifierModeleAvecProprietes(
  //     Modele modele, List<Propriety> nouvellesProprietes) async {
  //   final db = await database;

  //   // Démarrer une transaction
  //   await db.transaction((txn) async {
  //     // Mettre à jour le Modele
  //     await txn.update(
  //       DbConfig.modeleTable_name,
  //       modele.toJson(),
  //       where: 'uid = ?',
  //       whereArgs: [modele.uid],
  //     );

  //     // Supprimer les anciennes propriétés associées
  //     // await txn.delete(
  //     //   DbConfig.modProprietyTable_name,
  //     //   where: 'modeleUid = ?',
  //     //   whereArgs: [modele.uid],
  //     // );

  //     // Ajouter les nouvelles propriétés
  //     for (var propriete in nouvellesProprietes) {
  //       // Vérifier si la propriété existe déjà
  //       final proprieteExistante = await txn.query(
  //         DbConfig.proprietyTable_name,
  //         where: 'name = ?',
  //         whereArgs: [propriete.name],
  //       );

  //       // Insérer la propriété seulement si elle n'existe pas
  //       if (proprieteExistante.isEmpty) {
  //         //Inserer si  elle n'existe pas
  //         await txn.insert(
  //           DbConfig.proprietyTable_name,
  //           propriete.toJson(),
  //           conflictAlgorithm: ConflictAlgorithm.replace,
  //         );

  //       }
  //       //Au cas où elle existe ou vient d'être ajouter
  //       //Vérifier si elle est déjà lié

  //         final modPropriety = ModPropriety((b) => b
  //           ..uid = UniqueKey().toString()
  //           ..modeleUid = modele.uid
  //           ..proprietyUid = propriete.uid);

  //         await txn.insert(
  //           DbConfig.modProprietyTable_name,
  //           modPropriety.toJson(),
  //           conflictAlgorithm: ConflictAlgorithm.replace,
  //         );
  //       }
  //       /*
  //       // Mettre à jour ou insérer la Propriety
  //       await txn.insert(
  //         DbConfig.proprietyTable_name,
  //         propriete.toJson(),
  //         conflictAlgorithm: ConflictAlgorithm.replace,
  //       );

  //       // Lier la nouvelle Propriety au Modele
  //       final modPropriety = ModPropriety((b) => b
  //         ..uid = UniqueKey().toString()
  //         ..modeleUid = modele.uid
  //         ..proprietyUid = propriete.uid);

  //       await txn.insert(
  //         DbConfig.modProprietyTable_name,
  //         modPropriety.toJson(),
  //         conflictAlgorithm: ConflictAlgorithm.replace,
  //       );*/
  //     }
  //   });
  // }

  Future<void> supprimerModeleEtAssociations(String modeleUid) async {
    final db = await database;

    // Démarrer une transaction
    await db.transaction((txn) async {
      // Supprimer les associations dans modProprietyTable
      await txn.delete(
        DbConfig.modProprietyTable_name,
        where: 'modeleUid = ?',
        whereArgs: [modeleUid],
      );

      // Supprimer le modèle dans modeleTable
      await txn.delete(
        DbConfig.modeleTable_name,
        where: 'uid = ?',
        whereArgs: [modeleUid],
      );
    });
  }

  Future<List<Modele>> recupererTousLesModeles() async {
    final db = await database;

    // Récupérer tous les modèles de la table modeleTable_name
    final List<Map<String, dynamic>> modelesData =
        await db.query(DbConfig.modeleTable_name);

    // Si la table des modèles est vide, retourner une liste vide
    if (modelesData.isEmpty) {
      return [];
    }
    print("modelesData ${modelesData}");
    // Parcourir tous les modèles récupérés et récupérer leurs propriétés associées
    List<Modele> modeles = [];

    final List<Map<String, dynamic>> allRelations = await db.rawQuery('''
  SELECT * FROM ${DbConfig.modProprietyTable_name}
''');
    print("Relations Modèle-Propriétés: $allRelations");

    try {
      for (var modeleData in modelesData) {
        // Convertir les données en un objet Modele
        final modele = Modele.fromJson(modeleData);

        // Récupérer les propriétés associées au modèle en effectuant une jointure
        final List<Map<String, dynamic>> proprietiesData = await db.rawQuery('''
      SELECT p.* FROM ${DbConfig.proprietyTable_name} p
      INNER JOIN ${DbConfig.modProprietyTable_name} mp
      ON p.uid = mp.proprietyUid
      WHERE mp.modeleUid = ?
    ''', [modele.uid]);

        print("proprietiesData $proprietiesData");

        // Convertir les propriétés en objets Propriety
        final proprieties =
            proprietiesData.map((data) => Propriety.fromJson(data)).toList();

        // Ajouter les propriétés au modèle
        final modeleAvecProprietes =
            modele.rebuild((b) => b..proprieties.replace(proprieties));

        // Ajouter le modèle à la liste des modèles
        modeles.add(modeleAvecProprietes);
      }
    } catch (e) {
      log("error $e");
    }
    return modeles;
  }

  Future<List<Modele>> obtenirTousLesModelesAvecDetails() async {
    final db = await database;

    // Exécuter la requête SQL pour obtenir les données des tables
    final queryResult = await db.rawQuery('''
  SELECT 
    m.uid as modeleUid, 
    m.imgPath as modeleBaseImgPath,
    m.name as modeleBaseName,
    m.description as modeleBaseDescription,
    m.genderType as modeleBaseGenderType,
    m.creatorId as modeleBaseCreatorId,
    m.createdAt as modeleBaseCreatedAt,
    m.modifiedAt as modeleBaseModifiedAt,
    p.uid as proprietyUid,
    p.name as proprietyName,
    p.value as proprietyValue
  FROM 
    ${DbConfig.modeleTable_name} m 
  LEFT JOIN 
    ${DbConfig.modProprietyTable_name} mp ON m.uid = mp.modeleUid
  LEFT JOIN 
    ${DbConfig.proprietyTable_name} p ON mp.proprietyUid = p.uid
  ''');

    // Organiser le résultat de la requête
    return _organiserResultat(queryResult);
  }

  List<Modele> _organiserResultat(List<Map<String, dynamic>> queryResult) {
    final Map<String, ModeleBuilder> modelesMap = {};

    for (var row in queryResult) {
      final String modeleUid = row['modeleUid'];
      final String modeleBaseId = row['modeleBaseId'].toString();
      final String modeleBaseImgPath = row['modeleBaseImgPath'];
      final String modeleBaseName = row['modeleBaseName'];
      final String modeleBaseDescription = row['modeleBaseDescription'];
      final String modeleBaseGenderType = row['modeleBaseGenderType'];
      final String modeleBaseCreatorId = row['modeleBaseCreatorId'];
      final String modeleBaseCreatedAt = row['modeleBaseCreatedAt'];
      final String? modeleBaseModifiedAt = row['modeleBaseModifiedAt'] != null
          ? row['modeleBaseModifiedAt']
          : null;
      final String proprietyUid = row['proprietyUid'];
      final String proprietyName = row['proprietyName'];
      final String proprietyValue = row['proprietyValue'];

      // Création ou récupération du modèle
      if (!modelesMap.containsKey(modeleUid)) {
        modelesMap[modeleUid] = ModeleBuilder()
          ..uid = modeleUid
          ..imgPath = modeleBaseImgPath
          ..name = modeleBaseName
          ..description = modeleBaseDescription
          ..genderType = modeleBaseGenderType
          ..creatorId = modeleBaseCreatorId
          ..createdAt = modeleBaseCreatedAt
          ..modifiedAt = modeleBaseModifiedAt
          ..proprieties = ListBuilder<Propriety>();
      }

      // Ajout des propriétés au modèle
      if (proprietyUid != null) {
        final propriety = Propriety((b) => b
          ..uid = proprietyUid
          ..name = proprietyName
          ..value = proprietyValue);
        modelesMap[modeleUid]!.proprieties.add(propriety);
      }
    }

    return modelesMap.values.map((builder) => builder.build()).toList();
  }
}
