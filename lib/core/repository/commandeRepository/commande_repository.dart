import 'dart:developer';
import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/table_manager/client_helper.dart';
import 'package:atelier_so/core/database/table_manager/commande_helper.dart';
import 'package:atelier_so/core/database/table_manager/habit_helper.dart';
import 'package:atelier_so/core/modeles/client/client.dart';
import 'package:atelier_so/core/modeles/data_commande/commande/commande.dart';
import 'package:atelier_so/core/modeles/data_commande/habit/habit.dart';
import 'package:atelier_so/core/modeles/fields/user_create_fields/user_create_field.dart';
import 'package:atelier_so/core/modeles/message_event/message_event.dart';
import 'package:atelier_so/core/repository/clientRepository/client_repository.dart';
import 'package:atelier_so/core/repository/fileRepository/file_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@singleton
class CommandeRepository {
  ContextDistributor _contextDistributor;
  DatabaseHelper _databaseHelper;
  FileRepository _fileRepository;
  ClientRepository _clientRepository;

  BuildContext get context => _contextDistributor.context!;

  CommandeRepository(this._contextDistributor, this._databaseHelper,
      this._fileRepository, this._clientRepository);

  // Gestion des événements d'erreurs
  static MessageEvent setErrorEvent({
    required String msg,
    String? actionBtnText,
    required eventStyle type,
    required messageType typeInfo,
  }) {
    return MessageEvent(
      Message(typeInfo, 'Erreur', msg),
      style: type,
      btnActionTexte: actionBtnText ?? 'Réessayer',
      canceled: true,
    );
  }

  // Ajouter une commande
  Future<bool> saveCommande(
      Commande commande, List<Habit> habits, UserCreateField fields,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    try {
      /// Check if uid is null
      if (fields.uid == null) {
        fields.uid = const Uuid().v4();
      }
      print("step 1 : ");

      /// check if client already exists

      Client? client = await _databaseHelper.selectionnerClient(fields.uid!);
      print("step 2 : ");
      if (client == null) {
        print("step 3 : ");
        bool isAdded = await _clientRepository.saveClient(fields);
      } else {
        print("step 4 : ");
        await _clientRepository.updateClient(fields);
      }
      print("step 5 : ");
      //Rebuild la commande en ajouter l'uid du client
      commande = commande.rebuild((b) => b..clientUid = fields.uid);
      print("step 6 : ");
      // Sauvegarde de la commande complète avec les habits et les propriétés associées
      await _databaseHelper.ajouterCommandeComplete(commande, habits);
      operationOk = true;
    } catch (err) {
      log("Erreur lors de l'insertion de la commande : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur survenue! Veuillez réessayer ... $err",
        type: eventStyle.snack,
      );
    }

    if (event != null) {
      event.onBtnPressed = () {};
      event.context = context;
      if (!discretMode) {
        event.show();
      }
    }

    return operationOk;
  }

  // Mettre à jour une commande
  Future<bool> updateCommande(Commande commande, List<Habit> updatedHabits,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    try {
      // Modifier la commande avec les habits mis à jour
      await _databaseHelper.modifierCommande(commande);
      for (Habit habit in updatedHabits) {
        await _databaseHelper
            .modifierHabit(habit); // À implémenter dans votre DatabaseHelper
      }
      event = setErrorEvent(
        typeInfo: messageType.success,
        msg: "Commande mise à jour avec succès",
        type: eventStyle.snack,
      );
      operationOk = true;
    } catch (err) {
      log("Erreur lors de la mise à jour de la commande : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur survenue! Veuillez réessayer ... $err",
        type: eventStyle.snack,
      );
    }

    if (event != null) {
      event.onBtnPressed = () {};
      event.context = context;
      if (!discretMode) {
        event.show();
      }
    }

    return operationOk;
  }

  // Supprimer une commande
  Future<bool> deleteCommande(String commandeUid,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    try {
      // Suppression de la commande
      await _databaseHelper.supprimerCommande(commandeUid);
      event = setErrorEvent(
        typeInfo: messageType.success,
        msg: "Commande supprimée avec succès",
        type: eventStyle.snack,
      );
      operationOk = true;
    } catch (err) {
      log("Erreur lors de la suppression de la commande : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur survenue! Veuillez réessayer ... $err",
        type: eventStyle.snack,
      );
    }

    if (event != null) {
      event.onBtnPressed = () {};
      event.context = context;
      if (!discretMode) {
        event.show();
      }
    }

    return operationOk;
  }

  // Récupérer toutes les commandes avec habits et propriétés
  Future<List<Commande>> getCommandesWithHabitsAndProprieties_byClient(
      String clientUid) async {
    try {
      return await _databaseHelper
          .recupererCommandesAvecHabitsEtProprietes(clientUid);
    } catch (err) {
      log("Erreur lors de la récupération des commandes : $err");
      return [];
    }
  }

  Future<List<Commande>> getCommandesWithHabitsAndProprieties() async {
    try {
      return await _databaseHelper
          .recupererToutesLesCommandesAvecHabitsEtProprietes();
    } catch (err) {
      log("Erreur lors de la récupération des commandes : $err");
      return [];
    }
  }

  // RRécupérer une commande spécifique par UID
  Future<Commande?> getCommandeByUid(String uid) async {
    try {
      return await _databaseHelper.recupererCommande(uid);
    } catch (err) {
      log("Erreur lors de la récupération de la commande : $err");
      return null;
    }
  }

  // Méthode pour récupérer les commandes du jour
  Future<List<Commande>> getCommandesDuJour() async {
    try {
      return await _databaseHelper
          .recupererLesCommandesDuJourAvecHabitsEtProprietes();
    } catch (err) {
      log("Erreur lors de la récupération des commandes du jour : $err");
      return [];
    }
  }
}
