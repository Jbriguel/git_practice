import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:atelier_so/core/modeles/user/user.dart';
import 'package:atelier_so/core/modeles/user/user_mixin.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'owner.g.dart';

abstract class Owner
    with UserMixin
    implements UserInterface, Built<Owner, OwnerBuilder> {
  // Add specific fields for Owner
  String get entrepriseId;

  Owner._();
  factory Owner([void Function(OwnerBuilder) updates]) = _$Owner;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Owner.serializer, this)
        as Map<String, dynamic>;
  }

  static Owner fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Owner.serializer, json)!;
  }

  static Serializer<Owner> get serializer => _$ownerSerializer;
}
