import 'dart:developer';

import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/table_manager/client_helper.dart';
import 'package:atelier_so/core/modeles/client/client.dart';
import 'package:atelier_so/core/modeles/data_commande/commande/commande.dart';
import 'package:atelier_so/core/modeles/data_commande/habit/habit.dart';
import 'package:atelier_so/core/modeles/fields/user_create_fields/user_create_field.dart';
import 'package:atelier_so/core/repository/clientRepository/client_repository.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:built_collection/built_collection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../modeles/data_commande/habit_propriety/habit_propriety.dart';
import '../db_config.dart';

extension CommandeHelper on DatabaseHelper {
  // Table name
  static const String commandeTable = DbConfig.commandeTable_name;

  // Ajouter une commande
  Future<int> ajouterCommande(Commande commande) async {
    final db = await database;

    return await db.insert(
      commandeTable,
      commande.toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Remplace en cas de conflit sur uid
    );
  }

  // Modifier une commande
  Future<int?> modifierCommande(Commande commande) async {
    final db = await database;

    return db.update(
      commandeTable,
      commande.toMap(),
      where: 'uid = ?',
      whereArgs: [commande.uid],
      conflictAlgorithm: ConflictAlgorithm.ignore, // Ignore en cas de conflit
    );
  }

  // Récupérer une commande spécifique par UID
  Future<Commande?> recupererCommande(String uid) async {
    final db = await database;

    final queryResult = await db.query(
      commandeTable,
      where: 'uid = ?',
      whereArgs: [uid],
    );
    return queryResult.isNotEmpty ? Commande.fromMap(queryResult.first) : null;
  }

  // Supprimer une commande
  Future<int> supprimerCommande(String uid) async {
    final db = await database;

    return db.delete(
      commandeTable,
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  // Récupérer toutes les commandes
  Future<List<Commande>> recupererToutesLesCommandes() async {
    final db = await database;

    final queryResult = await db.query(commandeTable);

    return queryResult.map((json) => Commande.fromMap(json)).toList();
  }

//--------------------------------------

  // Fonction pour ajouter une commande complète avec habits et propriétés
  Future<void> ajouterCommandeComplete(
      Commande commande, List<Habit> habits) async {
    final db = await database;

    // Démarrer une transaction pour s'assurer que tout est inséré correctement
    await db.transaction((txn) async {
      log("commande ajoutée : $commande");
      // 1. Ajouter la commande dans la table commande
      final commandeUid = commande.uid ?? Uuid().v4();
      final commandeMap = commande.rebuild((b) => b..uid = commandeUid).toMap();
      log("commande ajoutée : $commandeMap");
      commandeMap.remove('habits');
      await txn.insert(
        commandeTable,
        commandeMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      log("commande ajoutée : $commandeMap");

      // 2. Ajouter chaque habit et ses propriétés
      for (var habit in habits) {
        final habitUid = habit.uid ?? Uuid().v4();
        final habitMap = habit
            .rebuild((b) => b
              ..uid = habitUid
              ..commandeUid = commandeUid)
            .toMap();

        // Ajouter l'habit à la table habit
        await txn.insert(
          habitTable,
          habitMap,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // 3. Ajouter les propriétés associées à l'habit
        for (var propriete in (habit.proprieties ?? <HabitPropriety>[])) {
          final proprietyMap = HabitPropriety((b) => b
            ..habitUid = habitUid
            ..name = propriete.name
            ..value = propriete.value).toMap();

          await txn.insert(
            habitProprietyTable,
            proprietyMap,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }
    });
  }

  //--------------------
  // Table name
  static const String habitTable = DbConfig.habitTable_name;
  static const String habitProprietyTable = DbConfig.habitProprietyTable_name;

  /// Renvoie la liste de toutes les commandes avec leurs habits et propriétés associées.
  ///
  /// La requête SQL utilisée est :
  ///
  Future<List<Commande>>
      recupererToutesLesCommandesAvecHabitsEtProprietes() async {
    final db = await database;

    // Requête SQL pour récupérer toutes les commandes, les habits associés et les propriétés associées
    final queryResult = await db.rawQuery('''
    SELECT 
      c.uid as commandeUid, 
      c.clientUid, 
      c.details as commandeDetails, 
      c.price as commandePrice, 
      c.advance as commandeAdvance, 
      c.deliveryDate as commandeDeliveryDate, 
      c.createdAt as commandeCreatedAt, 
      c.updatedAt as commandeUpdatedAt,
      
      h.uid as habitUid,
      h.name as habitName,
      h.details as habitDetails,
      h.image as habitImage,
      h.price as habitPrice,
      h.createdAt as habitCreatedAt,
      h.updatedAt as habitUpdatedAt,
      
      hp.name as proprietyName,
      hp.value as proprietyValue
      
    FROM $commandeTable c
    LEFT JOIN $habitTable h ON c.uid = h.commandeUid
    LEFT JOIN $habitProprietyTable hp ON h.uid = hp.habitUid
  ''');

    return _organiserCommandesAvecHabitsEtProprietes(queryResult);
  }

  // Récupérer toutes les commandes d'un client avec leurs habits et propriétés
  /// Récupère toutes les commandes d'un client avec leurs habits et propriétés.
  ///
  /// La requête SQL joint les tables commande, habit et habit_propriety pour
  /// récupérer les commandes, les habits associés et les propriétés associées.
  ///
  /// Les résultats sont organisés dans une liste de [Commande] avec leurs
  /// habits et propriétés respectives.
  ///
  /// [clientUid] est l'UID du client pour lequel on souhaite récupérer les
  /// commandes.
  Future<List<Commande>> recupererCommandesAvecHabitsEtProprietes(
      String clientUid) async {
    final db = await database;

    // Requête SQL pour récupérer les commandes, les habits associés et les propriétés associées
    final queryResult = await db.rawQuery('''
      SELECT 
        c.uid as commandeUid, 
        c.clientUid, 
        c.details as commandeDetails, 
        c.price as commandePrice, 
        c.advance as commandeAdvance, 
        c.deliveryDate as commandeDeliveryDate, 
        c.createdAt as commandeCreatedAt, 
        c.updatedAt as commandeUpdatedAt,
        
        h.uid as habitUid,
        h.name as habitName,
        h.details as habitDetails,
        h.image as habitImage,
        h.price as habitPrice,
        h.createdAt as habitCreatedAt,
        h.updatedAt as habitUpdatedAt,
        
        hp.name as proprietyName,
        hp.value as proprietyValue
        
      FROM $commandeTable c
      LEFT JOIN $habitTable h ON c.uid = h.commandeUid
      LEFT JOIN $habitProprietyTable hp ON h.uid = hp.habitUid
      WHERE c.clientUid = ?
    ''', [clientUid]);

    return _organiserCommandesAvecHabitsEtProprietes(queryResult);
  }

  // Organiser le résultat en objets Commande avec habits et propriétés

  /// Prend en paramètre le résultat d'une requête SQL qui inclut les commandes,
  /// les habits et les propriétés, et renvoie une liste de [Commande] avec leurs
  /// habits et propriétés respectives.
  ///
  /// Les commandes sont créées en premier, puis les habits et propriétés sont
  /// ajoutés à la commande appropriée. Si un habit existe déjà dans la commande,
  /// les propriétés sont ajoutées à l'habit existant au lieu de créer un nouvel
  /// habit.
  ///
  /// Les propriétés sont ajoutées à l'habit appropriée. Si la propriété existe
  /// déjà, elle n'est pas ajoutée à nouveau.
  ///
  /// Les commandes sont renvoyées dans l'ordre où elles apparaissent dans le
  /// résultat de la requête SQL.
  /* List<Commande> _organiserCommandesAvecHabitsEtProprietes(
      List<Map<String, dynamic>> queryResult) {
    final Map<String, CommandeBuilder> commandesMap = {};

    for (var row in queryResult) {
      final String commandeUid = row['commandeUid'];
      final String habitUid = row['habitUid'];
      final String proprietyName = row['proprietyName'];
      final String proprietyValue = row['proprietyValue'];
      print("Step 1");
      // Si la commande n'est pas encore dans le map, on la crée
      if (!commandesMap.containsKey(commandeUid)) {
        commandesMap[commandeUid] = CommandeBuilder()
          ..uid = commandeUid
          ..clientUid = row['clientUid'] as String?
          ..details = row['commandeDetails'] as String?
          ..price = row['commandePrice'] as double?
          ..advance = row['commandeAdvance'] as double?
          ..deliveryDate = row['commandeDeliveryDate'] as String?
          ..createdAt = row['commandeCreatedAt'] as String?
          ..updatedAt = row['commandeUpdatedAt'] as String?
          ..habits = ListBuilder<Habit>();
      }
      print("Step 2");
      // Ajout de l'habit à la commande
      if (habitUid != null && row['habitName'] != null) {
        HabitBuilder habit = HabitBuilder()
          ..uid = habitUid
          ..name = row['habitName'] as String?
          ..details = row['habitDetails'] as String?
          ..image = row['habitImage'] as String?
          ..price = row['habitPrice'] as double?
          ..createdAt = row['habitCreatedAt'] as String?
          ..updatedAt = row['habitUpdatedAt'] as String?
          ..proprieties = ListBuilder<HabitPropriety>();
        print("Step 3");
        // Ajout des propriétés à l'habit
        if (proprietyName != null && proprietyValue != null) {
          final propriety = HabitPropriety((b) => b
            ..name = proprietyName
            ..value = proprietyValue);
          habit.proprieties.add(propriety);
        }
        print("Step 4");
        // Si l'habit n'existe pas déjà dans la commande, on l'ajoute
        List<Habit> existingHabits =
            commandesMap[commandeUid]!.habits.build().toList();
        if (!existingHabits.any((h) => h.uid == habitUid)) {
          commandesMap[commandeUid]!.habits.add(habit.build());
        } else {
          // Si l'habit existe déjà, on y ajoute seulement les nouvelles propriétés
          // final existingHabit = commandesMap[commandeUid]!
          //     .habits
          //     .firstWhere((h) => h.uid == habitUid) as HabitBuilder;
          print("Step 5");
          // Trouver l'habit existant
          final existingHabitBuilder =
              existingHabits.firstWhere((h) => h.uid == habitUid).toBuilder();
          print("Step 6");
          // Ajouter les nouvelles propriétés à l'habit existant
          existingHabitBuilder.proprieties.add(HabitPropriety((b) => b
            ..name = proprietyName
            ..value = proprietyValue));
          print("Step 7");
          print(existingHabitBuilder.build());
          print("${existingHabits.toString()}");
          if (existingHabits.indexOf(existingHabitBuilder.build()) < 0)
            existingHabits.add(existingHabitBuilder.build());
          // Mettre à jour l'habit dans la liste des habits
          commandesMap[commandeUid]!.habits[
                  existingHabits.indexOf(existingHabitBuilder.build())] =
              existingHabitBuilder.build();
          print("Step 8");
        }
      }
    }

    return commandesMap.values.map((builder) => builder.build()).toList();
  }
*/
  List<Commande> _organiserCommandesAvecHabitsEtProprietes(
      List<Map<String, dynamic>> queryResult) {
    final Map<String, CommandeBuilder> commandesMap = {};
    log("queryResult : $queryResult");
    for (var row in queryResult) {
      final String commandeUid = row['commandeUid'];
      final String habitUid = row['habitUid'];
      final String proprietyName = row['proprietyName'];
      final String proprietyValue = row['proprietyValue'];

      // Si la commande n'est pas encore dans le map, on la crée
      if (!commandesMap.containsKey(commandeUid)) {
        commandesMap[commandeUid] = CommandeBuilder()
          ..uid = commandeUid
          ..clientUid = row['clientUid'] as String?
          ..details = row['commandeDetails'] as String?
          ..price = row['commandePrice'] as double?
          ..advance = row['commandeAdvance'] as double?
          ..deliveryDate = row['commandeDeliveryDate'] as String?
          ..createdAt = row['commandeCreatedAt'] as String?
          ..updatedAt = row['commandeUpdatedAt'] as String?
          ..habits = ListBuilder<Habit>();
      }

      // Ajout de l'habit à la commande
      if (habitUid != null && row['habitName'] != null) {
        HabitBuilder habit = HabitBuilder()
          ..uid = habitUid
          ..name = row['habitName'] as String?
          ..details = row['habitDetails'] as String?
          ..image = row['habitImage'] as String?
          ..price = row['habitPrice'] as double?
          ..createdAt = row['habitCreatedAt'] as String?
          ..updatedAt = row['habitUpdatedAt'] as String?
          ..proprieties = ListBuilder<HabitPropriety>();

        // Ajout des propriétés à l'habit
        if (proprietyName != null && proprietyValue != null) {
          final propriety = HabitPropriety((b) => b
            ..name = proprietyName
            ..value = proprietyValue);
          habit.proprieties.add(propriety);
        }

        // Si l'habit n'existe pas déjà dans la commande, on l'ajoute
        List<Habit> existingHabits =
            commandesMap[commandeUid]!.habits.build().toList();
        int existingHabitIndex =
            existingHabits.indexWhere((h) => h.uid == habitUid);

        if (existingHabitIndex == -1) {
          commandesMap[commandeUid]!.habits.add(habit.build());
        } else {
          // Mettre à jour l'habit existant avec les nouvelles propriétés
          final existingHabitBuilder =
              existingHabits[existingHabitIndex].toBuilder();

          // Ajouter les nouvelles propriétés à l'habit existant
          existingHabitBuilder.proprieties.add(HabitPropriety((b) => b
            ..name = proprietyName
            ..value = proprietyValue));

          // Mettre à jour l'habit dans la liste des habits
          commandesMap[commandeUid]!.habits[existingHabitIndex] =
              existingHabitBuilder.build();
        }
      }
    }

    return commandesMap.values.map((builder) => builder.build()).toList();
  }

  // Méthode pour récupérer les commandes avec la date de livraison égale à aujourd'hui
  /// Renvoie la liste des commandes dont la date de livraison est égale à la date
  /// actuelle.
  ///
  /// La méthode utilise la requête SQL suivante :
  ///
  ///
  ///
   Future<List<Commande>>
      recupererLesCommandesDuJourAvecHabitsEtProprietes() async {
    final db = await database;

       String dateAujourdhui =
        DateTime.now().toIso8601String().split('T')[0];

    // Requête SQL pour récupérer toutes les commandes, les habits associés et les propriétés associées
    final queryResult = await db.rawQuery('''
    SELECT 
      c.uid as commandeUid, 
      c.clientUid, 
      c.details as commandeDetails, 
      c.price as commandePrice, 
      c.advance as commandeAdvance, 
      c.deliveryDate as commandeDeliveryDate, 
      c.createdAt as commandeCreatedAt, 
      c.updatedAt as commandeUpdatedAt,
      
      h.uid as habitUid,
      h.name as habitName,
      h.details as habitDetails,
      h.image as habitImage,
      h.price as habitPrice,
      h.createdAt as habitCreatedAt,
      h.updatedAt as habitUpdatedAt,
      
      hp.name as proprietyName,
      hp.value as proprietyValue
      
    FROM $commandeTable c
    LEFT JOIN $habitTable h ON c.uid = h.commandeUid
    LEFT JOIN $habitProprietyTable hp ON h.uid = hp.habitUid

    WHERE DATE(commandeDeliveryDate) = ?
  ''', [dateAujourdhui]);

    return _organiserCommandesAvecHabitsEtProprietes(queryResult);
  }

  Future<List<Commande>> recupererCommandesDuJour() async {
    final db = await database;

    // Obtenir la date actuelle au format ISO (seulement la partie 'YYYY-MM-DD')
    final String dateAujourdhui =
        DateTime.now().toIso8601String().split('T')[0];

    final queryResult = await db.rawQuery('''
    SELECT * FROM ${DbConfig.commandeTable_name}
    WHERE DATE(deliveryDate) = ?
    ''', [dateAujourdhui]);

    return queryResult.map((json) => Commande.fromMap(json)).toList();
  }
}
