import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'propriety.g.dart';

abstract class Propriety implements Built<Propriety, ProprietyBuilder> {
  // Fields 
  String? get uid; 
  String? get name; 
  String? get value;

  // Constructor
  Propriety._();
  factory Propriety([void Function(ProprietyBuilder) updates]) = _$Propriety;

  // Serializer
  static Serializer<Propriety> get serializer => _$proprietySerializer;

  // Conversion methods
  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Propriety.serializer, this) as Map<String, dynamic>;
  }

  static Propriety fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Propriety.serializer, json)!;
  }
}
