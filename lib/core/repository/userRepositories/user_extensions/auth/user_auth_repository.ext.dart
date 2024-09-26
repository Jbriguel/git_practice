import 'dart:developer';
import 'dart:io';

import 'package:atelier_so/core/configuration/collections.dart';
import 'package:atelier_so/core/configuration/storages_folders.dart';
import 'package:atelier_so/core/functions/identify_generator.dart';
import 'package:atelier_so/core/functions/uid_generator.dart';
import 'package:atelier_so/core/functions/utiles_functions.dart';
import 'package:atelier_so/core/modeles/atelier/atelier.dart';
import 'package:atelier_so/core/modeles/entreprise/entreprise.dart';
import 'package:atelier_so/core/modeles/message_event/message_event.dart';
import 'package:atelier_so/core/modeles/owner/owner.dart';
import 'package:atelier_so/core/modeles/user/user.dart';
import 'package:atelier_so/core/repository/userRepositories/user_extensions/atelier/atelier_repository.ext.dart';
import 'package:atelier_so/core/repository/userRepositories/user_extensions/entreprise/entreprise_repository.ext.dart';
import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/services/firebase/firebase_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../functions/crypte.dart';

extension UserAuthExtension on UserRepository {
  Future<bool> registerOwnerUser(
      {required Owner owner,
      required Entreprise entreprise,
      File? logoFile}) async {
    String? logoUrl;
    if (logoFile != null) {
      logoUrl = await fileUploader((String message) {},
          file: logoFile,
          metaInfo: 'logo_${entreprise.entrepriseName}',
          type: 'image',
          savePath: StoragesFolders.entreprise_logo_folder(entreprise.uid),
          saveName: encodeName(entreprise.entrepriseName));
    }

    bool entrepriseIsSaved = await saveEntreprise(
        entreprise.rebuild((en) => en
          ..createdAt = DateTime.now().toUtc()
          ..logoUrl = logoUrl),
        discretMode: true);

    bool firstAtelierIsCreated = await createAtelier(
        Atelier((atlr) => atlr
          ..uid = UIDGenerator().generateUID()
          ..name = 'Atelier 1'
          ..adresse = ''
          ..entrepriseId = entreprise.uid
          ..identify = generateUniqueIdentify(DateTime.now())
          ..ownerId = owner.uid
          ..isDeleted = false
          ..createdAt = DateTime.now().toUtc()),
        discretMode: true);

    bool operationOk = false;
    MessageEvent? event;

    if (entrepriseIsSaved == true) {
      try {
        // Créer un utilisateur avec Firebase Authentication
        UserCredential userCredential =
            await FirebaseClient.auth.signInAnonymously();

        String uid = userCredential.user!.uid;

        // Créer un utilisateur dans Firestore
        String encrypte_password =
            await EncryptionService().encrypter(owner.password ?? '0000');

        Owner _owner = owner.rebuild((userOwner) => userOwner
          ..uid = uid
          ..role = "owner"
          ..entrepriseId = entreprise.uid
          ..password = encrypte_password
          ..createdAt = DateTime.now().toUtc());

        // Ajouter les informations de l'utilisateur dans Firestore
        await firestore.collection('users').doc(uid).set(_owner.toJson());

        // Creer une key pour un abonnement freemium
        String? SubscriptionKey =
            await abonnementRepository.createAbonnementKey(entreprise.uid);

        log("SubscriptionKey : $SubscriptionKey");
        //Ajouter cette key dans l'historique / abonnements au nom de l'entreprise
        await firestore
            .collection(Collections.historiques_abonnements_collection)
            .doc(entreprise.uid)
            .set({
          'current_subscription_key': SubscriptionKey,
          'old_abn_keys': []
        });

        // event = setErrorEvent(
        //   typeInfo: messageType.success,
        //   msg: "Utilisateur enregistré avec succès",
        //   type: eventStyle.snack,
        // );
        operationOk = true;
      } catch (e) {
        log("Erreur lors de l'enregistrement de l'utilisateur : $e");
        event = setErrorEvent(
          typeInfo: messageType.error,
          msg: "Erreur lors de l'enregistrement ! Veuillez réessayer ... $e",
          type: eventStyle.snack,
        );
      }
    } else {
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur lors de l'enregistrement ! Veuillez réessayer...",
        type: eventStyle.snack,
      );
    }

    if (event != null) {
      print("has an error");
      event.onBtnPressed = () {};
      event.context = context;
      event.show();
    }
    return operationOk;
  }

  // connexion avec gestion d'erreurs
  Future<bool> login({
    required String phone,
    required String password,
    required String identify,
    bool discretMode = false,
  }) async {
    MessageEvent? event;
    bool operationOk = false;

    Atelier? userAtelier;

    try {
      // Vérifier si l'identifiant est renseigné pour rechercher l'atelier
      if (identify.isNotEmpty) {
        // 1. Rechercher l'atelier avec l'`identify`
        final atelierSnapshot = await firestore
            .collection(Collections.ateliers_collection)
            .where('identify', isEqualTo: identify)
            .limit(1)
            .get();

        if (atelierSnapshot.docs.isEmpty) {
          event = setErrorEvent(
            typeInfo: messageType.error,
            msg: "Aucun atelier trouvé avec cet identifiant.",
            type: eventStyle.snack,
          );
          if (!discretMode && event != null) {
            event.show();
          }
          return operationOk;
        }

        final atelierData = atelierSnapshot.docs.first.data();
        final atelierId = atelierSnapshot.docs.first.id;

        // 2. Rechercher l'utilisateur dans la collection des utilisateurs
        final userSnapshot = await firestore
            .collection(Collections.users_collection)
            .where('phone', isEqualTo: phone)
            .where('atelierId', isEqualTo: atelierId)
            .limit(1)
            .get();

        if (userSnapshot.docs.isEmpty) {
          event = setErrorEvent(
            typeInfo: messageType.error,
            msg:
                "Utilisateur introuvable avec ce numéro de téléphone pour cet atelier.",
            type: eventStyle.snack,
          );
          if (!discretMode && event != null) {
            event.show();
          }
          return operationOk;
        }

        final userData = userSnapshot.docs.first.data();
        final userPassword = userData['password'];
        String decrypte_password =
            await EncryptionService().decrypter(userPassword ?? '0000');

        // 3. Vérifier si le mot de passe correspond
        if (decrypte_password != password) {
          event = setErrorEvent(
            typeInfo: messageType.error,
            msg: "Mot de passe incorrect ou Numero de telephone incorrect.",
            type: eventStyle.snack,
          );
          if (!discretMode && event != null) {
            event.show();
          }
          return operationOk;
        }

        // 4. Vérifier le rôle de l'utilisateur
        final String userRole =
            userData['role']; // Exemple : 'employe' ou 'manager'

        if (userRole == 'manager' || userRole == 'employe') {
          // 5. Récupérer l'atelier auquel appartient cet utilisateur
          final String? userAtelierId =
              userData['atelierId']; // Si l'utilisateur a un atelier associé

          if (userAtelierId != null) {
            final userAtelierSnapshot = await firestore
                .collection(Collections.ateliers_collection)
                .doc(userAtelierId)
                .get();

            if (userAtelierSnapshot.exists) {
              final atelierData = userAtelierSnapshot.data();
              // event = setErrorEvent(
              //   typeInfo: messageType.success,
              //   msg: "Connexion réussie.",
              //   type: eventStyle.snack,
              // );
              operationOk = true;
            } else {
              event = setErrorEvent(
                typeInfo: messageType.error,
                msg: "Atelier introuvable pour cet utilisateur.",
                type: eventStyle.snack,
              );
            }
          } else {
            event = setErrorEvent(
              typeInfo: messageType.error,
              msg: "Cet utilisateur n'est associé à aucun atelier.",
              type: eventStyle.snack,
            );
          }
        } else {
          // --
          userAtelier = Atelier.fromJson(atelierData);
          setUser(Owner.fromJson(userData));

          //Recupere la key de l'abonnement en cours
          abonnementRepository
              .getEntrepriseAbonnement_infosEtKey(userAtelier.entrepriseId);

          // Recuperer les permissions et les informations sur l'abonnement en cours
          abonnementRepository.getEntrepriseAbonnementETPermissions();

          // event = setErrorEvent(
          //   typeInfo: messageType.success,
          //   msg: "Connexion réussie.",
          //   type: eventStyle.snack,
          // );
          operationOk = true;
        }
      } else {
        // Si l'identifiant n'est pas renseigné, chercher parmi les propriétaires
        final ownerSnapshot = await firestore
            .collection(Collections.users_collection)
            .where('phone', isEqualTo: phone)
            .where('role', isEqualTo: 'owner')
            .limit(1)
            .get();

        if (ownerSnapshot.docs.isEmpty) {
          event = setErrorEvent(
            typeInfo: messageType.error,
            msg: "Propriétaire introuvable avec ce numéro de téléphone.",
            type: eventStyle.snack,
          );
          if (!discretMode) {
            event.show();
          }
          return operationOk;
        }

        final ownerData = ownerSnapshot.docs.first.data();
        final ownerPassword = ownerData['password'];

        String decrypte_password =
            await EncryptionService().decrypter(ownerPassword ?? '0000');
        print("decrypte_password : $decrypte_password");
        // Vérifier si le mot de passe correspond
        if (decrypte_password != password) {
          event = setErrorEvent(
            typeInfo: messageType.error,
            msg: "Mot de passe incorrect.",
            type: eventStyle.snack,
          );
          if (!discretMode) {
            event.show();
          }
          return operationOk;
        }

        // Associer l'utilisateur au propriétaire
        try {
          Owner _owner = Owner.fromJson(ownerData);
          print("owner : ${_owner.toJson()}");
          //Recupere la key de l'abonnement en cours
          abonnementRepository
              .getEntrepriseAbonnement_infosEtKey(_owner.entrepriseId);

          // Recuperer les permissions et les informations sur l'abonnement en cours
          abonnementRepository.getEntrepriseAbonnementETPermissions();
        } catch (e) {
          print("error $e");
        }

        setUser(Owner.fromJson(ownerData));

        // event = setErrorEvent(
        //   typeInfo: messageType.success,
        //   msg: "Connexion réussie.",
        //   type: eventStyle.snack,
        // );
        operationOk = true;
      }
    } catch (e) {
      log("Erreur lors de la tentative de connexion : $e");
      event = setErrorEvent(
        typeInfo: messageType.error,
        msg: "Erreur lors de la tentative de connexion : $e",
        type: eventStyle.snack,
      );
    }

    // Afficher l'événement en cas d'erreur ou de succès
    if (!discretMode && event != null) {
      event.show();
    }

    return operationOk;
  }
}
