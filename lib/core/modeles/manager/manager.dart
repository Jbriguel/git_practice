import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:atelier_so/core/modeles/user/user_mixin.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../user/user.dart';
 
part 'manager.g.dart';

abstract class Manager  with UserMixin implements UserInterface, Built<Manager, ManagerBuilder> {
  // Add specific fields for Manager
  String get entrepriseId;

  Manager._();
  factory Manager([void Function(ManagerBuilder) updates]) = _$Manager;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Manager.serializer, this) as Map<String, dynamic>;
  }

  static Manager fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Manager.serializer, json)!;
  }

  static Serializer<Manager> get serializer => _$managerSerializer;
}