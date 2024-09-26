import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'atelier.g.dart';

abstract class Atelier implements Built<Atelier, AtelierBuilder> {
  String get uid;
  String get entrepriseId;
  String get ownerId;
  String get name;
  String get identify;
  String? get adresse;

  bool? get isDeleted;

  DateTime? get createdAt;
  DateTime? get modifiedAt;
  DateTime? get deletedAt;

  Atelier._();
  factory Atelier([void Function(AtelierBuilder) updates]) = _$Atelier;

  Map<String, dynamic> toJson() {
    final json = serializers.serializeWith(Atelier.serializer, this)
        as Map<String, dynamic>;

    return json;
  }

  static Atelier fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Atelier.serializer, json)!;
  }

  /// Gestion des `Timestamp` dans Firestore et conversion en `DateTime`
  static Atelier fromMap(Map<String, dynamic> json) {
    return Atelier((a) => a
      ..uid = json['uid'] as String
      ..entrepriseId = json['entrepriseId'] as String
      ..ownerId = json['ownerId'] as String
      ..name = json['name'] as String
      ..identify = json['identify'] as String
      ..adresse = json['adresse'] as String?
      ..isDeleted = json['isDeleted'] as bool?
      ..createdAt = (json['createdAt'] != null)
          ? (json['createdAt'] as Timestamp).toDate()
          : null
      ..modifiedAt = (json['modifiedAt'] != null)
          ? (json['modifiedAt'] as Timestamp).toDate()
          : null
      ..deletedAt = (json['deletedAt'] != null)
          ? (json['deletedAt'] as Timestamp).toDate()
          : null);
  }

  static Serializer<Atelier> get serializer => _$atelierSerializer;
}
