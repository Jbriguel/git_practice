import 'dart:convert';

import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'client.g.dart';

abstract class Client implements Built<Client, ClientBuilder> {
  // Fields

  int? get id;
  String? get photoUrl;
  String? get iconName;
  String? get nomComplet;
  String? get phone;
  String? get email;
  String? get adresse;
  String? get uid;
  String? get informationsSuppelementaires;
  BuiltList<BuiltMap<String, dynamic>>? get mesures;

  DateTime get createdAt;
  DateTime get updatedAt;
  int get isDeleted;

  // Constructors
  Client._();
  factory Client([void Function(ClientBuilder) updates]) = _$Client;

  // Serialization
  static Serializer<Client> get serializer => _$clientSerializer;

  //--------------------------------------------------------//

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Client.serializer, this)
        as Map<String, dynamic>;
  }

  static Client fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Client.serializer, json)!;
  }

  //--------------------------------------------------------//
  // Conversion int -> bool
  bool get isDeletedBool => isDeleted == 1;

// Conversion bool -> int
  int boolToInt(bool value) => value ? 1 : 0;

  // Convertir un Client en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photoUrl': photoUrl,
      'iconName': iconName,
      'nomComplet': nomComplet,
      'phone': phone,
      'email': email,
      'adresse': adresse,
      'uid': uid,
      'informationsSuppelementaires': informationsSuppelementaires,
      'mesures': jsonEncode(mesures
          ?.map((e) => e.toMap())
          .toList()), // Conversion des BuiltList en List
      'createdAt': createdAt.toIso8601String(), // Conversion DateTime en String
      'updatedAt': updatedAt.toIso8601String(),
      'isDeleted': isDeleted,
    };
  }

  // Convertir un Client en Map pour SQLite
  Map<String, dynamic> toMap_forPdf() {
    return {
      'Nom Complet': nomComplet,
      'Tel': phone,
      'Adresse Email': email,
      'Adresse': adresse,
      'informations Supplémentaires': informationsSuppelementaires,
      'Mesures': jsonEncode(mesures?.map((e) => e.toMap()).toList()),
    };
  }

  // Créer un Client à partir d'une Map SQLite
  static Client fromMap(Map<String, dynamic> map) {
    return Client((b) => b
      ..id = map['id'] as int?
      ..photoUrl = map['photoUrl'] as String?
      ..iconName = map['iconName'] as String?
      ..nomComplet = map['nomComplet'] as String?
      ..phone = map['phone'] as String?
      ..email = map['email'] as String?
      ..adresse = map['adresse'] as String?
      ..uid = map['uid'] as String?
      ..informationsSuppelementaires =
          map['informationsSuppelementaires'] as String?
      ..mesures = /* map['mesures'] != null
          ? ListBuilder((jsonDecode(map['mesures']) as List).map(
              (e) => BuiltMap<String, dynamic>.from(e as Map<String, dynamic>)))
          : ListBuilder(
              [])*/
          ListBuilder(map['mesures'] ?? []) // Conversion des List en BuiltList
      ..createdAt = map['createdAt'] == null
          ? DateTime.now()
          : DateTime.fromMicrosecondsSinceEpoch(int.parse(map[
              'createdAt'])) /*DateTime.parse(
              map['createdAt'] as String)*/ // Conversion String en DateTime
      ..updatedAt = map['updatedAt'] == null
          ? DateTime.now()
          : DateTime.fromMicrosecondsSinceEpoch(int.parse(
              map['updatedAt'])) // DateTime.parse(map['updatedAt'] as String)
      ..isDeleted = map['isDeleted'] != null ? map['isDeleted'] as int : 0);
  }
}
