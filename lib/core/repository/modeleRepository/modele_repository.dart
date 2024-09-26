import 'dart:developer';
import 'dart:io';
import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/table_manager/modele_helper.dart';
import 'package:atelier_so/core/modeles/data_modeles/modele/modele.dart';
import 'package:atelier_so/core/modeles/data_modeles/propriety/propriety.dart';
import 'package:atelier_so/core/modeles/message_event/message_event.dart';
import 'package:atelier_so/core/repository/fileRepository/file_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class ModeleRepository {
  ContextDistributor _contextDistributor;
  DatabaseHelper _databaseHelper;
  FileRepository _fileRepository;

  BuildContext get context => _contextDistributor.context!;

  ModeleRepository(
      this._contextDistributor, this._databaseHelper, this._fileRepository);

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

  Future<bool> saveModele(Modele modele, List<Propriety> proprietes,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    try {
      // Si une image est fournie, assurez-vous de la gérer correctement
      if (modele.imgPath != null) {
        File? imageFile =
            await _fileRepository.getLocalImageFile(modele.imgPath!, "modeles");
        // Assurez-vous que le chemin de l'image est correctement utilisé dans votre base de données
        modele = modele.rebuild((b) => b..imgPath = imageFile?.path);
      }

      // Utiliser la méthode pour ajouter le modèle et ses propriétés
      await _databaseHelper.ajouterModeleAvecProprietes(modele, proprietes);

      operationOk = true;
    } catch (err) {
      log("Erreur lors de l'insertion du modèle : $err");
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

  Future<bool> saveModele_withoutImage(
      Modele modele, List<Propriety> proprietes,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    try {
      // Utiliser la méthode pour ajouter le modèle et ses propriétés
      await _databaseHelper.ajouterModeleAvecProprietes(modele, proprietes);
      event = setErrorEvent(
        typeInfo: messageType.success,
        msg: "Modèle ajouté avec succès",
        type: eventStyle.snack,
      );
      operationOk = true;
    } catch (err) {
      log("Erreur lors de l'insertion du modèle : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur survenue! Veuillez réessayer ... $err",
        type: eventStyle.snack,
      );
    }

    if (event != null) {
      event!.onBtnPressed = () {};
      event!.context = context;
      if (!discretMode) {
        event!.show();
      }
    }

    return operationOk;
  }

  Future<bool> deleteModele(String modeleUid,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    try {
      // Utiliser la méthode pour supprimer le modèle et ses associations
      await _databaseHelper.supprimerModeleEtAssociations(modeleUid);
      event = setErrorEvent(
        typeInfo: messageType.success,
        msg: "Modèle supprimé avec succès",
        type: eventStyle.snack,
      );
      operationOk = true;
    } catch (err) {
      log("Erreur lors de la suppression du modèle : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur survenue! Veuillez réessayer ... $err",
        type: eventStyle.snack,
      );
    }

    if (event != null) {
      event!.onBtnPressed = () {};
      event!.context = context;
      if (!discretMode) {
        event!.show();
      }
    }

    return operationOk;
  }

  Future<bool> updateModele(Modele modele, List<Propriety> nouvellesProprietes,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    log("updateModele > nouvellesProprietes ${nouvellesProprietes.map((e) => e.name)}");

    try {
      // Utiliser la méthode pour mettre à jour le modèle et ses propriétés
      await _databaseHelper.modifierModeleAvecProprietes(
          modele, nouvellesProprietes);
      event = setErrorEvent(
        typeInfo: messageType.success,
        msg: "Modèle mis à jour avec succès",
        type: eventStyle.snack,
      );
      operationOk = true;
    } catch (err) {
      log("Erreur lors de la mise à jour du modèle : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur survenue! Veuillez réessayer ... $err",
        type: eventStyle.snack,
      );
    }

    if (event != null) {
      event!.onBtnPressed = () {};
      event!.context = context;
      if (!discretMode) {
        event!.show();
      }
    }

    return operationOk;
  }

  Future<List<Modele>> getModeles() async {
    try {
      return await _databaseHelper.obtenirTousLesModelesAvecDetails();
    } catch (err) {
      log("Erreur lors de la récupération des modèles : $err");
      return [];
    }
  }

  Future<Modele?> getModeleByUid(String uid) async {
    try {
      return await _databaseHelper.obtenirModeleAvecProprietes(uid);
    } catch (err) {
      log("Erreur lors de la récupération du modèle par UID : $err");
      return null;
    }
  }
}
