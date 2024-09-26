import 'package:atelier_so/core/configuration/collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:atelier_so/core/modeles/entreprise/entreprise.dart';
import 'package:atelier_so/core/modeles/message_event/message_event.dart';
import 'dart:developer';

import '../../user_repository.dart';

extension EntrepriseRepository on UserRepository {

  Future<bool> saveEntreprise(Entreprise entreprise,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;
    
    try {
      final entrepriseRef =
          firestore.collection(Collections.entreprise_collection).doc(entreprise.uid);

      final entrepriseData = entreprise.toJson();
      entrepriseData['createdAt'] =  DateTime.now().toUtc();
      entrepriseData['isDeleted'] = false;

      await entrepriseRef.set(entrepriseData);
      event = setErrorEvent(
        typeInfo: messageType.success,
        msg: "Entreprise ajoutée avec succès",
        type: eventStyle.snack,
      );
      operationOk = true;
    } catch (err) {
      log("Erreur lors de l'ajout de l'entreprise : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur lors de l'ajout de l'entreprise",
        type: eventStyle.snack,
      );
    }

    if (!discretMode) {
      event.show();
    }

    return operationOk;
  }
/*
  Future<bool> updateEntreprise(Entreprise entreprise,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    try {
      final entrepriseRef =
          _firestore.collection(collectionPath).doc(entreprise.uid);

      final entrepriseData = entreprise.toJson();
      entrepriseData['modifiedAt'] = FieldValue.serverTimestamp();

      await entrepriseRef.update(entrepriseData);
      event = MessageEvent.success(
          "Entreprise mise à jour avec succès", eventStyle.snack);
      operationOk = true;
    } catch (err) {
      log("Erreur lors de la mise à jour de l'entreprise : $err");
      event = MessageEvent.error(
          "Erreur lors de la mise à jour de l'entreprise", eventStyle.snack);
    }

    if (!discretMode && event != null) {
      event.show();
    }

    return operationOk;
  }

  Future<bool> deleteEntreprise(String entrepriseUid,
      {bool softDelete = true, bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    try {
      final entrepriseRef =
          _firestore.collection(collectionPath).doc(entrepriseUid);

      if (softDelete) {
        // Suppression logique (soft delete) en mettant à jour le champ `isDeleted`
        await entrepriseRef.update({
          'isDeleted': true,
          'deletedAt': FieldValue.serverTimestamp(),
        });
      } else {
        // Suppression physique (hard delete) depuis Firestore
        await entrepriseRef.delete();
      }

      event = MessageEvent.success(
          "Entreprise supprimée avec succès", eventStyle.snack);
      operationOk = true;
    } catch (err) {
      log("Erreur lors de la suppression de l'entreprise : $err");
      event = MessageEvent.error(
          "Erreur lors de la suppression de l'entreprise", eventStyle.snack);
    }

    if (!discretMode && event != null) {
      event.show();
    }

    return operationOk;
  }

  // Fonction pour récupérer une entreprise à partir de son uid
  Future<Entreprise?> getEntreprise(String entrepriseUid) async {
    try {
      final entrepriseRef =
          _firestore.collection(collectionPath).doc(entrepriseUid);
      final docSnapshot = await entrepriseRef.get();

      if (docSnapshot.exists) {
        return Entreprise.fromJson(docSnapshot.data()!);
      }
    } catch (err) {
      log("Erreur lors de la récupération de l'entreprise : $err");
    }

    return null;
  }*/
}
