import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'abonnement.g.dart';

abstract class Abonnement implements Built<Abonnement, AbonnementBuilder> {
  String get uid;
  String get abonementName;
  String get abonnementKey;
  DateTime get createdAt;

  Abonnement._();
  factory Abonnement([void Function(AbonnementBuilder) updates]) = _$Abonnement;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Abonnement.serializer, this) as Map<String, dynamic>;
  }

  static Abonnement fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Abonnement.serializer, json)!;
  }

  static Serializer<Abonnement> get serializer => _$abonnementSerializer;
}
