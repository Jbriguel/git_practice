import 'package:atelier_so/core/modeles/data_modeles/propriety/propriety.dart';
import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'modele.g.dart';

abstract class Modele implements Built<Modele, ModeleBuilder> {
  // Fields
  String? get uid;
  String? get imgPath;
  String? get name;
  String? get description;
  String? get genderType;
  String? get creatorId;
  String get createdAt;
  String? get modifiedAt;
  BuiltList<Propriety> get proprieties;

  // Constructor
  Modele._();
  factory Modele([void Function(ModeleBuilder) updates]) = _$Modele;

  // Serializer
  static Serializer<Modele> get serializer => _$modeleSerializer;

  @override
  String toString() {
    return '''$runtimeType( le name:\n\t modeleInfo: $name,\n\t proprieties: $proprieties''';
  }

  //--------------------------------------------------------//

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Modele.serializer, this)
        as Map<String, dynamic>;

    // final data = serializers.serializeWith(Modele.serializer, this)
    //     as Map<String, dynamic>;

    // // Convertir les dates en format ISO 8601 pour l'insertion dans la base de données
    // data['createdAt'] = createdAt.toIso8601String();
    // data['modifiedAt'] = modifiedAt?.toIso8601String();

    // return data;
  }

  static Modele fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Modele.serializer, json)!;
    // return serializers.deserializeWith(
    //   Modele.serializer,
    //   json
    //     ..['createdAt'] = DateTime.parse(json['createdAt'])
    //     ..['modifiedAt'] = json['modifiedAt'] != null
    //         ? DateTime.parse(json['modifiedAt'])
    //         : null,
    // )!;
  }

  //--------------------------------------------------------//
}
