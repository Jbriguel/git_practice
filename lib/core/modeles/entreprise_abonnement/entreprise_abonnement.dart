
import 'package:atelier_so/core/modeles/permission/permission.dart';
import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'entreprise_abonnement.g.dart';

abstract class EntrepriseAbonnement implements Built<EntrepriseAbonnement, EntrepriseAbonnementBuilder> {
  List<Permission> get permissions;
  String get entrepriseAbonementKey;
  DateTime get createdAt;
  DateTime get expiredAt;


  EntrepriseAbonnement._();
  factory EntrepriseAbonnement([void Function(EntrepriseAbonnementBuilder) updates]) = _$EntrepriseAbonnement;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(EntrepriseAbonnement.serializer, this) as Map<String, dynamic>;
  }

 
  static EntrepriseAbonnement fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(EntrepriseAbonnement.serializer, json)!;
  }

  static Serializer<EntrepriseAbonnement> get serializer => _$entrepriseAbonnementSerializer;
}
