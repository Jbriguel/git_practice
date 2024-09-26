import 'package:atelier_so/core/modeles/user/user.dart';
import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:atelier_so/core/modeles/user/user_mixin.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'employe.g.dart';

abstract class Employe
    with UserMixin
    implements UserInterface, Built<Employe, EmployeBuilder> {
  // Add specific fields for Employe
  String get atelierId;
  String get atelierIdentify;

  Employe._();
  factory Employe([void Function(EmployeBuilder) updates]) = _$Employe;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Employe.serializer, this)
        as Map<String, dynamic>;
  }

  static Employe fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Employe.serializer, json)!;
  }

  static Serializer<Employe> get serializer => _$employeSerializer;
}
