import 'dart:convert';
import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'habit_propriety.g.dart';

abstract class HabitPropriety implements Built<HabitPropriety, HabitProprietyBuilder> {
  // Fields
  int? get id;
  String? get habitUid;  // Lié à la table Habit
  String? get name;      // Nom de la propriété (copié depuis le modèle)
  String? get value;     // Valeur de la propriété
  String? get createdAt;  // Stocké sous forme de String
  String? get updatedAt; // Stocké sous forme de String

  // Constructor
  HabitPropriety._();
  factory HabitPropriety([void Function(HabitProprietyBuilder) updates]) = _$HabitPropriety;

  // Serializer
  static Serializer<HabitPropriety> get serializer => _$habitProprietySerializer;

  //--------------------------------------------------------//

  // Convertir une HabitPropriety en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'habitUid': habitUid,
      'name': name,
      'value': value,
      'createdAt': createdAt,         // Stocké en String
      'updatedAt': updatedAt,         // Stocké en String
    };
  }

  // Créer une HabitPropriety à partir d'une Map SQLite
  static HabitPropriety fromMap(Map<String, dynamic> map) {
    return HabitPropriety((b) => b
      ..id = map['id'] as int?
      ..habitUid = map['habitUid'] as String?
      ..name = map['name'] as String?
      ..value = map['value'] as String?
      ..createdAt = map['createdAt'] as String      // Directement stocké en String
      ..updatedAt = map['updatedAt'] as String?);
  }

  // Serialization
  Map<String, dynamic> toJson() {
    return serializers.serializeWith(HabitPropriety.serializer, this)
        as Map<String, dynamic>;
  }

  static HabitPropriety fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(HabitPropriety.serializer, json)!;
  }
}
