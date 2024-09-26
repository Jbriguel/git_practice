import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'entreprise.g.dart';

abstract class Entreprise implements Built<Entreprise, EntrepriseBuilder> {
  String get uid;
  String get entrepriseName;
  String get logoUrl;
  String get description;
  bool? get hasAbonement;
  String? get entrepriseAbonementKey;
  String? get ownerId;
  bool? get isDeleted;
  DateTime get createdAt;
  DateTime? get modifiedAt;
  DateTime? get deletedAt;

  Entreprise._();
  factory Entreprise([void Function(EntrepriseBuilder) updates]) = _$Entreprise;

  Map<String, dynamic> toJson() {
    final json = serializers.serializeWith(Entreprise.serializer, this)
        as Map<String, dynamic>;

    return json;
  }

  static Entreprise fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Entreprise.serializer, json)!;
  }

  static Serializer<Entreprise> get serializer => _$entrepriseSerializer;
}
