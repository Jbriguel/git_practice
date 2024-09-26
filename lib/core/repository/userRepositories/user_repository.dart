import 'dart:developer';
import 'package:atelier_so/core/functions/crypte.dart';
import 'package:atelier_so/core/local_storage/local_storage.dart';
import 'package:atelier_so/core/local_storage/subscription_helper.dart';
import 'package:atelier_so/core/local_storage/user_local_helper.dart';
import 'package:atelier_so/core/modeles/atelier/atelier.dart';
import 'package:atelier_so/core/modeles/entreprise/entreprise.dart';
import 'package:atelier_so/core/modeles/entreprise_abonnement/entreprise_abonnement.dart';
import 'package:atelier_so/core/modeles/message_event/message_event.dart';
import 'package:atelier_so/core/modeles/permission/permission.dart';
import 'package:atelier_so/core/modeles/subscription_info/subscription.dart';
import 'package:atelier_so/core/modeles/subscription_info/subscription_info.dart';
import 'package:atelier_so/core/modeles/user/user.dart';
import 'package:atelier_so/core/repository/abonnementRepository/abonnement_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/services/firebase/firebase_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserRepository extends ChangeNotifier {
  ContextDistributor contextDistributor;
  FirebaseClient firebaseClient;
  AppLocalData appLocalData;
  AbonnementRepository abonnementRepository;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  BuildContext get context => contextDistributor.context!;

  UserInterface? user;
  Entreprise? entreprise;
  Atelier? userAtelier;
  List<Permission> permissions = [];

  UserRepository(this.firebaseClient, this.contextDistributor,
      this.appLocalData, this.abonnementRepository);

  Future<void> loadDataFromLocal() async {
    user = await appLocalData.getUser();
    if (user != null) {
      abonnementRepository.loadSubscriptionFromLocal();
    }
    notifyListeners();
  }

  MessageEvent setErrorEvent(
      {required String msg,
      String? actionBtnText,
      required eventStyle type,
      required messageType typeInfo}) {
    return MessageEvent(Message(typeInfo, 'Erreur', msg),
        style: type,
        btnActionTexte: actionBtnText ?? 'Réessayer',
        canceled: true,
        context: contextDistributor.context);
  }

  String? get userRole => user?.role;
  void setUser(UserInterface? _user) {
    user = _user;
    if (user != null) {
      appLocalData.setUser(user!);
    }
    notifyListeners();
  }

  void setUserAtelier(Atelier? _userAtelier) {
    userAtelier = _userAtelier;
    notifyListeners();
  }

  void setEntreprise(Entreprise? _entreprise) {
    entreprise = _entreprise;
    notifyListeners();
  }

  void logout() async {
    user = null;
    appLocalData.clearUser();
    appLocalData.clearSubscription();
    appLocalData.clearSubscriptionKey();
    appLocalData.clear();
    notifyListeners();
  }

  Future<bool> updateUserRole(String uid, String newRole) async {
    bool operationOk = false;
    MessageEvent? event;

    try {
      // Mettre à jour le rôle de l'utilisateur dans Firestore
      await firestore.collection('users').doc(uid).update({
        'role': newRole,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      event = setErrorEvent(
        typeInfo: messageType.success,
        msg: "Rôle mis à jour avec succès",
        type: eventStyle.snack,
      );
      operationOk = true;
    } catch (e) {
      log("Erreur lors de la mise à jour du rôle de l'utilisateur : $e");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg:
            "Erreur lors de la mise à jour du rôle ! Veuillez réessayer ... $e",
        type: eventStyle.snack,
      );
    }

    if (event != null) {
      print("has an error");
      event!.onBtnPressed = () {};
      event!.context = context;
      event!.show();
    }

    return operationOk;
  }
}

/*
Structure abonnement entreprise
{'entreprise_key':'b2a4ab9f-79a6-4035-94ab-84da37793050',
'ABN_key':'256b1873-caa1-4492-991d-095ae2826680',
'startedAt':'15-09-2024',
'delay':'7'
}
*/