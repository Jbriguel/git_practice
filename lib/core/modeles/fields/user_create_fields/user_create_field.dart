import 'package:json_annotation/json_annotation.dart';
import 'package:built_collection/built_collection.dart';

part 'user_create_field.g.dart';

@JsonSerializable()
class UserCreateField {
  String nomComplet;
  String adresse;
  String phone;
  String? email;
  String? uid;
  String photoUrl;
  String? informationsSuppelementaires;
  List<Map<String, dynamic>> mesures;

  UserCreateField({
    required this.nomComplet,
    required this.adresse,
    required this.phone,
    this.email,
    this.uid,
    required this.photoUrl,
    this.informationsSuppelementaires,
    required this.mesures,
  });

  // Conversion de JSON à l'objet
  factory UserCreateField.fromJson(Map<String, dynamic> json) =>
      _$UserCreateFieldFromJson(json);

  // Conversion de l'objet au JSON
  Map<String, dynamic> toJson() => _$UserCreateFieldToJson(this);
}
