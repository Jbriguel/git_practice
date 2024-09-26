import 'package:atelier_so/core/configuration/collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:atelier_so/core/modeles/manager/manager.dart';

import '../../user_repository.dart'; // Assure-toi d'importer le modèle Manager

extension ManagerRepository on UserRepository {
  /// Liste tous les managers d'une entreprise
  Future<List<Manager>> listManagersByEntreprise(String? entrepriseId) async {
    if (entrepriseId == null) return [];
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection(Collections.users_collection)
          .where('entrepriseId', isEqualTo: entrepriseId)
          .where('role', isEqualTo: 'manager') // Filtrer par rôle manager
          .get();

      List<Manager> managers = querySnapshot.docs
          .map((doc) => Manager.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return managers;
    } catch (e) {
      print('Error listing managers: $e');
    }
    return [];
  }

  /// Supprime un manager par ID
  Future<void> deleteManager(String uid) async {
    try {
      await firestore
          .collection(Collections.users_collection)
          .doc(uid)
          .delete();
    } catch (e) {
      print('Error deleting manager: $e');
    }
  }

  /// Modifie les détails d'un manager
  Future<void> updateManager(String uid, Map<String, dynamic> updates) async {
    try {
      await firestore
          .collection(Collections.users_collection)
          .doc(uid)
          .update(updates);
    } catch (e) {
      print('Error updating manager: $e');
    }
  }

  /// Récupère un manager par ID
  Future<Manager?> getManagerById(String uid) async {
    try {
      DocumentSnapshot doc = await firestore
          .collection(Collections.users_collection)
          .doc(uid)
          .get();
      if (doc.exists) {
        return Manager.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        print('Manager not found');
        return null;
      }
    } catch (e) {
      print('Error getting manager: $e');
      return null;
    }
  }

  /// Met à jour le rôle d'un employé pour devenir manager
  Future<void> promoteToManager(String uid) async {
    try {
      // Met à jour le rôle de l'employé pour le promouvoir en tant que manager
      await firestore
          .collection(Collections.users_collection)
          .doc(uid)
          .update({'role': 'manager'});
    } catch (e) {
      print('Error promoting to manager: $e');
    }
  }

  /// Met à jour le rôle d'un employé pour devenir manager
  Future<void> retrograderManagerToEmployer(String uid) async {
    try {
      // Retrograder un Manager à employer
      await firestore
          .collection(Collections.users_collection)
          .doc(uid)
          .update({'role': 'employe'});
    } catch (e) {
      print('Error retrograding manager to employer: $e');
    }
  }
}
