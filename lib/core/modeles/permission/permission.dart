import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:built_value/built_value.dart'; 
import 'package:built_value/serializer.dart';

part 'permission.g.dart';

abstract class Permission implements Built<Permission, PermissionBuilder> {
  String get uid;
  String get permissionName; 
  DateTime get createdAt;

  Permission._();
  factory Permission([void Function(PermissionBuilder) updates]) = _$Permission;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Permission.serializer, this) as Map<String, dynamic>;
  }

  static Permission fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Permission.serializer, json)!;
  }

  static Serializer<Permission> get serializer => _$permissionSerializer;
}
