import 'dart:developer';

import 'package:atelier_so/core/configuration/collections.dart';
import 'package:atelier_so/core/modeles/atelier/atelier.dart';
import 'package:atelier_so/core/modeles/entreprise/entreprise.dart';
import 'package:atelier_so/core/modeles/message_event/message_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../user_repository.dart';

extension AtelierRepository on UserRepository {
  Future<bool> createAtelier(Atelier atelier,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    try {
      final atelierRef = firestore
          .collection(Collections.ateliers_collection)
          .doc(atelier.uid);

      final atelierData = atelier.toJson();
      atelierData['createdAt'] = DateTime.now().toUtc();
      atelierData['isDeleted'] = false;

      await atelierRef.set(atelierData);
      event = setErrorEvent(
        typeInfo: messageType.success,
        msg: "Atelier ajoutée avec succès",
        type: eventStyle.snack,
      );
      operationOk = true;
    } catch (err) {
      log("Erreur lors de l'ajout de l'atelier : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur lors de l'ajout de l'atelier",
        type: eventStyle.snack,
      );
    }

    if (!discretMode) {
      event.show();
    }

    return operationOk;
  }

  //Lister les ateliers
  Future<List<Atelier>> listAteliers() async {
    MessageEvent? event;
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection(Collections.ateliers_collection)
          .where('isDeleted', isEqualTo: false)
          .get();
      List<Atelier> ateliers = querySnapshot.docs
          .map((doc) => Atelier.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return ateliers;
    } catch (e) {
      log("Erreur lors de la lecture de la liste des ateliers : $e");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur lors de la lecture de la liste des ateliers : $e",
        type: eventStyle.snack,
      );
    }

    event.show();
    return [];
  }

  //lister les ateliers d'une entreprise
  Future<List<Atelier>> listAteliersByEntreprise(String? entrepriseId) async {
    MessageEvent? event;
    if (entrepriseId == null) return [];
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection(Collections.ateliers_collection)
          .where('isDeleted', isEqualTo: false)
          .where('entrepriseId', isEqualTo: entrepriseId)
          .get();
      List<Atelier> ateliers = querySnapshot.docs
          .map((doc) => Atelier.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return ateliers;
    } catch (e) {
      print('Error listing ateliers: $e');
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur lors de la recupération des ateliers : $e",
        type: eventStyle.snack,
      );
    }

    event.show();
    return [];
  }
}
