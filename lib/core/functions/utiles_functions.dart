// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

///VERIFER LA CONNEXION INTERNET

Future<bool> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true; // Connexion Internet disponible
    }
  } on SocketException catch (_) {
    return false; // Pas de connexion Internet
  }
  return false; // Pas de connexion Internet
}

//Get file name with extension
Future<String?> getFileNameWithExtension(File file) async {
  if (await file.exists()) {
    //To get file name without extension
    //path.basenameWithoutExtension(file.path);

    //return file with file extension
    return path.basename(file.path);
  } else {
    return null;
  }
}

String getFileExtension(File file) {
  String fileExtension = path.extension(file.path);
  print(fileExtension);
  return fileExtension;
}

String encodeName(String str) {
  final strBytes = utf8.encode(str);
  final base64String = base64.encode(strBytes);
  return base64String;
}

//--------------------------------------------------------------------//
///VERIFIER SI l'ELEMENT (LA VALEUR) CORRESPOND AU CHAMP DONNER DANS LA COLLECTION DONNEE
///EN GROS VERIFIER L'EXISTANCE D'UN DOCUMENT EN FONCTION D'UN CHAMP OU UNE VALEUR
//--------------------------------------------------------------------//

Future<bool> thisElementExiste_InThisCollection(
    String elementName, String fieldName, String collectionName) async {
  ValueNotifier<bool> existe = ValueNotifier<bool>(false);

  bool retour = await FirebaseFirestore.instance
      .collection(collectionName)
      .where(fieldName, isEqualTo: elementName)
      .get()
      .then((QuerySnapshot querySnapshot) {
    print("querySnapshot ${querySnapshot.docs.length}");
    if (querySnapshot.docs.isNotEmpty) {
      print('*True');
      existe.value = true;
      existe.notifyListeners();
      print('*existe : ${existe.value}');
      return existe.value;
    } else {
      print('*false');
      existe.value = false;
      existe.notifyListeners();
      print('*existe : ${existe.value}');
      return existe.value;
    }
    // ignore: void_checks
  }).whenComplete(() {
    print('*complet');
    print('*existe : ${existe.value}');
    return existe.value;
  });

  return retour;
}

Future<bool> updateElement(
    String collectionName, Map<String, dynamic> data, String docId) async {
  bool retour = false;

  await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(docId)
      .set(data, SetOptions(merge: true))
      .then((_) {
    // Succès de la mise à jour des données
    print('La mise à jour des données a réussi !');
    retour = true;
  }).catchError((error) {
    retour = false;
    print("error: $error");
  });
  return retour;
}

String idGenerator() {
  final now = DateTime.now();
  return now.microsecondsSinceEpoch.toString();
}

//############# ONLINE OPERATIONS ##################//
//--------------------------------------------------------------------//
//AJOUTER DES ELEMENTS OU DOCUMENT A UNE COLLECTION
Future<DocumentReference<Map<String, dynamic>>> addElement(
    String collectionName, Map<String, dynamic> element) async {
  return await FirebaseFirestore.instance
      .collection(collectionName)
      .add(element);
}

Future<DocumentReference<Object?>> addElementAutoID(
    String collectionName, Map<String, dynamic> element, {String idName = 'id'}) async {
  DocumentReference ref =
      FirebaseFirestore.instance.collection(collectionName).doc();
  element[idName] = ref.id;
  ref.set(element);
  return ref;
}

//############# UPDATE DOCUMENT FIELD ##################//

Future<bool> updateField(void Function(String value) setMessage,
    {required String collection,
    required String docName,
    String? field,
    required String type,
    required dynamic data}) async {
  var dateUtc = DateTime.now().toUtc();

  bool isConnected = await checkInternetConnection();
  if (isConnected) {
    switch (type) {
      case "liste":
        FirebaseFirestore.instance.collection(collection).doc(docName).update({
          "$field": FieldValue.arrayUnion([data]),
        });
        break;
      case "string":
        FirebaseFirestore.instance.collection(collection).doc(docName).update({
          "$field": data,
        });
        break;
      case "map":
        FirebaseFirestore.instance
            .collection(collection)
            .doc(docName)
            .update(data);
        break;
      default:
        FirebaseFirestore.instance.collection(collection).doc(docName).update({
          "$field": data,
        });
    }

    return true;
  } else {
    setMessage(
        'Problème de connexion Internet. Veuillez vérifier votre connexion.');
    return false;
  }
}

//############# UPLOAD IMAGE TO STORAGE ONLINE ##################//

Future<String?> fileUploader(void Function(String value) setMessage,
    {required File file,
    required String metaInfo,
    required String type,
    required String savePath,
    required saveName}) async {
  String? downloadUrl;

  String ext = getFileExtension(file);
  // Create the file metadata
  final metadata = SettableMetadata(contentType: "$type/$ext");

  // Create a reference to the Firebase Storage bucket
  final storageRef = FirebaseStorage.instance.ref();

  //  Upload file and metadata to the path'
  print("file new format : $savePath/$saveName$ext");
  final uploadTask = storageRef
      .child("$savePath/$saveName$ext")
      .putFile(file, metadata)
      .whenComplete(() {
    print('file saved');
  });

  downloadUrl = await (await uploadTask).ref.getDownloadURL();

  return downloadUrl;
}


//--------------------
getAbonnementColor(String type) {
    switch (type) {
      case "Standard":
        return Colors.blue.shade400;
      case "Tchiwara":
        return Colors.green.shade400;
      case "Sanu":
        return Colors.yellow.shade400;
      default:
        return Colors.blue.shade400;
    }
  }