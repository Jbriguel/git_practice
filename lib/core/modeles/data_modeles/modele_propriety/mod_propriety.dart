import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mod_propriety.g.dart';

abstract class ModPropriety implements Built<ModPropriety, ModProprietyBuilder> {
  // Fields 
  String get uid; 
  String get modeleUid; 
  String get proprietyUid;

  // Constructor
  ModPropriety._();
  factory ModPropriety([void Function(ModProprietyBuilder) updates]) = _$ModPropriety;

  // Serializer
  static Serializer<ModPropriety> get serializer => _$modProprietySerializer;

  
  //--------------------------------------------------------//

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ModPropriety.serializer, this)
        as Map<String, dynamic>;
  }

  static ModPropriety fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ModPropriety.serializer, json)!;
  }

  //--------------------------------------------------------//
}
