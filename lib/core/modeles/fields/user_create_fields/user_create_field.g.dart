// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateField _$UserCreateFieldFromJson(Map<String, dynamic> json) =>
    UserCreateField(
      nomComplet: json['nomComplet'] as String,
      adresse: json['adresse'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      uid: json['uid'] as String?,
      photoUrl: json['photoUrl'] as String,
      informationsSuppelementaires:
          json['informationsSuppelementaires'] as String?,
      mesures: (json['mesures'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$UserCreateFieldToJson(UserCreateField instance) =>
    <String, dynamic>{
      'nomComplet': instance.nomComplet,
      'adresse': instance.adresse,
      'phone': instance.phone,
      'email': instance.email,
      'uid': instance.uid,
      'photoUrl': instance.photoUrl,
      'informationsSuppelementaires': instance.informationsSuppelementaires,
      'mesures': instance.mesures,
    };
