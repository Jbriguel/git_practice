import 'dart:developer';

import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/table_manager/propriety_helper.dart';
import 'package:atelier_so/core/modeles/data_modeles/propriety/propriety.dart';
import 'package:atelier_so/core/modeles/message_event/message_event.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class ProprietyRepository {
  final ContextDistributor _contextDistributor;
  final DatabaseHelper _databaseHelper;

  BuildContext get context => _contextDistributor.context!;

  ProprietyRepository(this._contextDistributor, this._databaseHelper);

  // Méthode utilitaire pour générer des événements de message
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

  // Enregistrer une nouvelle propriété dans la base de données
  Future<bool> savePropriety(Propriety propriety,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;
     

    await createPropriety(propriety).then((value) {
      if (value != 0) {
        event = setErrorEvent(
          typeInfo: messageType.success,
          msg: "Propriété ajoutée",
          type: eventStyle.snack,
        );
        operationOk = true;
      } else {
        event = setErrorEvent(
          typeInfo: messageType.error,
          msg: "Erreur survenue! Veuillez réessayer",
          type: eventStyle.snack,
        );
      }
    }).catchError((err) {
      log("Erreur lors de l'insertion de la propriété : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur survenue! Veuillez réessayer ... $err",
        type: eventStyle.snack,
      );
    });

    if (event != null) {
      event!.onBtnPressed = () {};
      event!.context = context;
      if (!discretMode) {
        event!.show();
      }
    }

    return operationOk;
  }

  // Supprimer une propriété de la base de données par UID
  Future<bool> deleteProprietyByUid(String proprietyUid,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    await deletePropriety(proprietyUid).then((value) {
      if (value != 0) {
        event = setErrorEvent(
          typeInfo: messageType.success,
          msg: "Propriété supprimée",
          type: eventStyle.snack,
        );
        operationOk = true;
      } else {
        event = setErrorEvent(
          typeInfo: messageType.error,
          msg: "Erreur survenue! Veuillez réessayer",
          type: eventStyle.snack,
        );
      }
    }).catchError((err) {
      log("Erreur lors de la suppression de la propriété : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur survenue! Veuillez réessayer ... $err",
        type: eventStyle.snack,
      );
    });

    if (event != null) {
      event!.onBtnPressed = () {};
      event!.context = context;
      if (!discretMode) {
        event!.show();
      }
    }

    return operationOk;
  }

  // Supprimer toutes les propriétés de la base de données
  Future<void> deleteAllProprieties({bool discretMode = false}) async {
    MessageEvent? event;

    await _databaseHelper.deleteAllProprieties().then((_) {
      event = setErrorEvent(
        typeInfo: messageType.success,
        msg: "Toutes les propriétés ont été supprimées",
        type: eventStyle.snack,
      );
    }).catchError((err) {
      log("Erreur lors de la suppression de toutes les propriétés : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur survenue! Veuillez réessayer ... $err",
        type: eventStyle.snack,
      );
    });

    if (event != null && !discretMode) {
      event!.context = context;
      event!.show();
    }
  }

  // Mettre à jour une propriété dans la base de données
  Future<bool> updateProprietyInDb(Propriety propriety,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    await updatePropriety(propriety).then((value) {
      if (value != 0) {
        event = setErrorEvent(
          typeInfo: messageType.success,
          msg: "Propriété mise à jour",
          type: eventStyle.snack,
        );
        operationOk = true;
      } else {
        event = setErrorEvent(
          typeInfo: messageType.error,
          msg: "Erreur survenue! Veuillez réessayer",
          type: eventStyle.snack,
        );
      }
    }).catchError((err) {
      log("Erreur lors de la mise à jour de la propriété : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur survenue! Veuillez réessayer ... $err",
        type: eventStyle.snack,
      );
    });

    if (event != null) {
      event!.onBtnPressed = () {};
      event!.context = context;
      if (!discretMode) {
        event!.show();
      }
    }

    return operationOk;
  }

  // Récupérer toutes les propriétés de la base de données
  Future<List<Propriety>> getProprieties() async {
    try {
      return await getAllProprieties();
    } catch (err) {
      log("Erreur lors de la récupération des propriétés : $err");
      return [];
    }
  }

  // Récupérer une propriété spécifique par UID
  Future<Propriety?> getProprietyByUid(String uid) async {
    try {
      return await getPropriety(uid);
    } catch (err) {
      log("Erreur lors de la récupération de la propriété par UID : $err");
      return null;
    }
  }

  // Méthodes de base de données
  Future<int> createPropriety(Propriety propriety) async {
    return await _databaseHelper.createPropriety(propriety);
  }

  Future<Propriety?> getPropriety(String uid) async {
    return await _databaseHelper.getPropriety(uid);
  }

  Future<List<Propriety>> getAllProprieties() async {
    return await _databaseHelper.getAllProprieties();
  }

  Future<int> updatePropriety(Propriety propriety) async {
    return await _databaseHelper.updatePropriety(propriety);
  }

  Future<int> deletePropriety(String uid) async {
    return await _databaseHelper.deletePropriety(uid);
  }
}
