import 'dart:developer';

import 'package:atelier_so/core/configuration/collections.dart';
import 'package:atelier_so/core/modeles/employe/employe.dart';
import 'package:atelier_so/core/modeles/message_event/message_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:atelier_so/core/modeles/user/user.dart';
import 'package:atelier_so/core/modeles/user/user_mixin.dart';

import '../../user_repository.dart';

extension EmployeRepository on UserRepository {
  Future<bool> addNewEmploye(Employe employe,
      {bool discretMode = false}) async {
    bool operationOk = false;
    MessageEvent? event;

    try {
      final entrepriseRef =
          firestore.collection(Collections.users_collection).doc(employe.uid);

      final employeData = employe.toJson();
      // employeData['createdAt'] = DateTime.now().toUtc();
      // employeData['isDeleted'] = false;

      await entrepriseRef.set(employeData);

      operationOk = true;
    } catch (err) {
      log("Erreur lors de l'ajout de l'employer : $err");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur lors de l'ajout de l'employer",
        type: eventStyle.snack,
      );
    }

    if (!discretMode && event != null) {
      event.show();
    }

    return operationOk;
  }

  /// Liste tous les employés d'une entreprise ayant un rôle spécifique
  Future<List<Employe>> listEmployes(String? entrepriseId) async {
    if (entrepriseId == null) return [];
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection(Collections.users_collection)
          .where('entrepriseId', isEqualTo: entrepriseId)
          .where('role', isEqualTo: 'employe')
          .where('isDeleted', isEqualTo: false)
          .get();

      List<Employe> employes = querySnapshot.docs
          .map((doc) => Employe.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return employes;
    } catch (e) {
      print('Error listing employes: $e');
      return [];
    }
  }

  /// Supprime un employé par ID
  Future<void> deleteEmploye(String uid) async {
    try {
      await firestore
          .collection(Collections.users_collection)
          .doc(uid)
          .update({"phone": null, "email": null, "isDeleted": true});
    } catch (e) {
      print('Error deleting employe: $e');
    }
  }

  /// Modifie les détails d'un employé
  Future<void> updateEmploye(String uid, Map<String, dynamic> updates) async {
    try {
      await firestore
          .collection(Collections.users_collection)
          .doc(uid)
          .update(updates);
    } catch (e) {
      print('Error updating employe: $e');
    }
  }

  /// Récupère un employé par ID
  Future<Employe?> getEmployeById(String uid) async {
    try {
      DocumentSnapshot doc = await firestore
          .collection(Collections.users_collection)
          .doc(uid)
          .get();
      if (doc.exists) {
        return Employe.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        print('Employe not found');
        return null;
      }
    } catch (e) {
      print('Error getting employe: $e');
      return null;
    }
  }
}
