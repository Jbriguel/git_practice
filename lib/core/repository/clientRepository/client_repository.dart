import 'dart:developer';
import 'dart:io';

import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/table_manager/client_helper.dart';
import 'package:atelier_so/core/modeles/client/client.dart';
import 'package:atelier_so/core/modeles/fields/user_create_fields/user_create_field.dart';
import 'package:atelier_so/core/modeles/message_event/message_event.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart'; // Importez ce package pour utiliser basename
import 'package:path_provider/path_provider.dart';

import '../fileRepository/file_repository.dart';

@singleton
class ClientRepository {
  ContextDistributor _contextDistributor;
  DatabaseHelper _databaseHelper;
  FileRepository _fileRepository;

  BuildContext get context => _contextDistributor.context!;

  ClientRepository(
      this._contextDistributor, this._databaseHelper, this._fileRepository);

  static MessageEvent setErrorEvent(
      {required String msg,
      String? actionBtnText,
      required eventStyle type,
      required messageType typeInfo}) {
    return MessageEvent(
      Message(typeInfo, 'Erreur', msg),
      style: type,
      btnActionTexte: actionBtnText ?? 'Réessayer',
      canceled: true,
    );
  }

  Future<bool> saveClient(UserCreateField userCreateField,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;
    // Obtenez le répertoire des documents de l'application
    final Directory directory = await getApplicationDocumentsDirectory();

    // Obtenez le fichier image local
    File? localImageClient = await _fileRepository.getLocalImageFile(
        userCreateField.photoUrl, "clients");

    // Créez une instance de Client
    final client = Client((b) => b
      ..nomComplet = userCreateField.nomComplet
      ..adresse = userCreateField.adresse
      ..phone = userCreateField.phone
      ..email = userCreateField.email
      ..uid = userCreateField.uid
      ..photoUrl = localImageClient?.path
      ..informationsSuppelementaires =
          userCreateField.informationsSuppelementaires
      ..mesures = ListBuilder(userCreateField.mesures)
      ..createdAt = DateTime.now().toUtc()
      ..updatedAt = DateTime.now().toUtc()
      ..isDeleted = 0);

    // Insérez le nouveau client dans la base de données
    await _databaseHelper.ajouterClients([client]).then((value) {
      if (value != 0) {
        // event = setErrorEvent(
        //   typeInfo: messageType.success,
        //   msg: "Client Ajouté",
        //   type: eventStyle.snack,
        // );
        operationOk = true;
      } else {
        event = setErrorEvent(
          typeInfo: messageType.error,
          msg: "Erreur Survenue! Veuillez réessayer",
          type: eventStyle.snack,
        );
      }
    }).catchError((err) {
      log("erreur insertion client : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur Survenue! Veuillez réessayer ... $err",
        type: eventStyle.snack,
      );
    });

    if (event != null) {
      print("has an error");
      event!.onBtnPressed = () {};
      event!.context = context;
      if (!discretMode) {
        event!.show();
      }
    }

    return operationOk;
  }

  Future<bool> updateClient(UserCreateField userCreateField,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    // Récupérer le client actuel à partir de la base de données
    Client? existingClient =
        await _databaseHelper.selectionnerClient(userCreateField.uid!);

    if (existingClient == null) {
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Client non trouvé",
        type: eventStyle.snack,
      );
    } else {
      // Obtenez le fichier image local (si la photo a changé)
      File? newLocalImageClient;
      if (userCreateField.photoUrl != null &&
          userCreateField.photoUrl != existingClient.photoUrl) {
        newLocalImageClient = await _fileRepository.getLocalImageFile(
            userCreateField.photoUrl, "clients");
      }

      // Créer une copie du client avec les modifications
      final updatedClient = existingClient.rebuild((b) {
        if (userCreateField.nomComplet != null &&
            userCreateField.nomComplet != existingClient.nomComplet) {
          b.nomComplet = userCreateField.nomComplet;
        }
        if (userCreateField.adresse != null &&
            userCreateField.adresse != existingClient.adresse) {
          b.adresse = userCreateField.adresse;
        }
        if (userCreateField.phone != null &&
            userCreateField.phone != existingClient.phone) {
          b.phone = userCreateField.phone;
        }
        if (userCreateField.email != null &&
            userCreateField.email != existingClient.email) {
          b.email = userCreateField.email;
        }
        if (newLocalImageClient != null) {
          b.photoUrl = newLocalImageClient.path;
        }
        if (userCreateField.informationsSuppelementaires != null &&
            userCreateField.informationsSuppelementaires !=
                existingClient.informationsSuppelementaires) {
          b.informationsSuppelementaires =
              userCreateField.informationsSuppelementaires;
        }
        if (userCreateField.mesures != null &&
            userCreateField.mesures != existingClient.mesures) {
          b.mesures = ListBuilder(userCreateField.mesures);
        }
        b.createdAt = b.createdAt!.toUtc();
        b.updatedAt = DateTime.now().toUtc();
      });

      // Mettre à jour le client dans la base de données
      await _databaseHelper.modifierClient(updatedClient).then((value) {
        if (value != 0) {
          operationOk = true;
        } else {
          event = setErrorEvent(
            typeInfo: messageType.error,
            msg: "Erreur Survenue! Veuillez réessayer",
            type: eventStyle.snack,
          );
        }
      }).catchError((err) {
        log("Erreur lors de la mise à jour du client : $err");
        event = setErrorEvent(
          typeInfo: messageType.error,
          msg: "Erreur Survenue! Veuillez réessayer ... $err",
          type: eventStyle.snack,
        );
      });
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

  Future<bool> deleteClient(String clientUid,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    // Insérez le nouveau client dans la base de données
    await _databaseHelper.supprimerClient(clientUid).then((value) {
      if (value != 0) {
        event = setErrorEvent(
          typeInfo: messageType.success,
          msg: "Client supprimé",
          type: eventStyle.snack,
        );
        operationOk = true;
      } else {
        event = setErrorEvent(
          typeInfo: messageType.error,
          msg: "Erreur Survenue! Veuillez réessayer",
          type: eventStyle.snack,
        );
      }
    }).catchError((err) {
      log("erreur insertion client : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur Survenue! Veuillez réessayer ... $err",
        type: eventStyle.snack,
      );
    });

    if (event != null) {
      print("has an error");
      event!.onBtnPressed = () {};
      event!.context = context;
      if (!discretMode) {
        event!.show();
      }
    }

    return operationOk;
  }
}
