import 'dart:developer';

import 'package:atelier_so/core/configuration/collections.dart';
import 'package:atelier_so/core/configuration/documents.dart';
import 'package:atelier_so/core/functions/crypte.dart';
import 'package:atelier_so/core/local_storage/local_storage.dart';
import 'package:atelier_so/core/local_storage/subscription_helper.dart';
import 'package:atelier_so/core/modeles/entreprise_abonnement/entreprise_abonnement.dart';
import 'package:atelier_so/core/modeles/subscription_info/subscription.dart';
import 'package:atelier_so/core/modeles/subscription_info/subscription_info.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/services/firebase/firebase_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@singleton
class AbonnementRepository extends ChangeNotifier {
  ContextDistributor contextDistributor;
  FirebaseClient firebaseClient;
  AppLocalData appLocalData;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  BuildContext get context => contextDistributor.context!;

  String? currentAbonnementKey;
  SubscriptionInfo? subscriptionInfo; //le map encoder dans currentAbonnementKey
  Subscription? currentSubscription;

  AbonnementRepository(
      this.firebaseClient, this.contextDistributor, this.appLocalData);

  SubscriptionInfo? get currentAbonnement => subscriptionInfo;

  void loadSubscriptionFromLocal() async {
    currentSubscription = await appLocalData.getSubscription();
    currentAbonnementKey = await appLocalData.getSubscriptionKey();
    print("currentAbonnementKey: $currentAbonnementKey");
    print("currentSubscription: ${currentSubscription?.toMap()}");
    if (currentAbonnementKey != null) {
      Map<String, dynamic> data =
          await EncryptionService().decryptMap(currentAbonnementKey!);
      subscriptionInfo = SubscriptionInfo.fromMap(data);
      print("subscriptionInfo: ${subscriptionInfo?.toMap()}");
    }

    notifyListeners();
  }

  Future<void> getEntrepriseAbonnement_infosEtKey(String entrepriseID) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection(Collections.historiques_abonnements_collection)
        .doc(entrepriseID) // L'identifiant de l'entreprise
        .get();

    if (docSnapshot.exists) {
      // Recuperer la key de l'abonnement en cours
      String? subAbnKey = docSnapshot.get('current_subscription_key');

      currentAbonnementKey = subAbnKey;
      if (subAbnKey != null) {
        //Save en local
        appLocalData.setSubscriptionKey(subAbnKey);
        Map<String, dynamic> data =
            await EncryptionService().decryptMap(subAbnKey);
        subscriptionInfo = SubscriptionInfo.fromMap(data);
      }
    }
    notifyListeners();
  }

  Future<void> getEntrepriseAbonnementETPermissions() async {
    if (subscriptionInfo != null) {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection(Collections.historiques_abonnements_collection)
          .doc(Documents.abonnement_document)
          .get();

      if (docSnapshot.exists) {
        // Recuperer la key de l'abonnement en cours
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        Subscription? sub =
            getSubscriptionByKey(data, subscriptionInfo!.abnKey);
        currentSubscription = sub;
        print(
            "getEntrepriseAbonnementETPermissions=> currentSubscription: ${currentSubscription?.toMap()}");
        if (sub != null) {
          //Save en local
          appLocalData.setSubscription(sub);
        }
      }
    }
    notifyListeners();
  }

  Future<String?> createAbonnementKey(String entrepriseID) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection(Collections.app_info_collection)
        .doc(Documents.abonnement_document)
        .get();
    log("docSnapshot : $docSnapshot");
    if (docSnapshot.exists) {
      // Recuperer la key de l'abonnement en cours
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

      // log("docSnapshot data : $data");
      Subscription? sub = getSubscriptionByName(data, "freemium");

      //log("sub : ${sub?.toMap()}");
      if (sub != null) {
        // Récupérer la date actuelle
        DateTime currentDate = DateTime.now();
        // Formater la date sous le format 'dd-MM-yyyy'
        String formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);

        SubscriptionInfo newSubscriptionInfo = SubscriptionInfo(
            abnKey: sub.key,
            entrepriseKey: entrepriseID,
            delay: sub.delay ?? 0,
            startedAt: formattedDate);
        try {
          String _subscriptionKey =
              await EncryptionService().encryptMap(newSubscriptionInfo.toMap());
          return _subscriptionKey;
        } catch (e) {
          log(' message : ${e.toString()}');
        }
      }
    } else {
      //log("docSnapshot : no exists");
    }

    return null;
  }

  Subscription? getSubscriptionByKey(
      Map<String, dynamic> data, String keyValue) {
    // Parcourt chaque entrée du Map et vérifie si la clé correspond
    for (var abn in data.values) {
      if (abn['key'] == keyValue) {
        return Subscription.fromMap(abn); // Retourne l'abonnement correspondant
      }
    }
    return null; // Retourne null si aucun abonnement ne correspond
  }

  Subscription? getSubscriptionByName(
      Map<String, dynamic> data, String keyValue) {
    // Parcourt chaque entrée du Map et vérifie si la clé correspond
    for (var abn in data.values) {
      if (abn['name'] == keyValue) {
        try {
          return Subscription.fromMap(
              abn); // Retourne l'abonnement correspondant
        } catch (e) {
          //  log("message : ${e.toString()}");
        }
      }
    }
    return null; // Retourne null si aucun abonnement ne correspond
  }
}
