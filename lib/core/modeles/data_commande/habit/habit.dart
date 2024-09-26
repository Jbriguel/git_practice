import 'dart:convert';
import 'package:atelier_so/core/modeles/data_commande/habit_propriety/habit_propriety.dart';
import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'habit.g.dart';

abstract class Habit implements Built<Habit, HabitBuilder> {
  // Fields
  int? get id;
  String? get uid;
  String? get commandeUid;
  String? get modeleUid;
  String? get name;
  String? get details;
  String? get image; // Chemin de l'image associée à l'habit
  double? get price; // Prix de l'habit
  String? get createdAt; // Stocké sous forme de String
  String? get updatedAt; // Stocké sous forme de String

  BuiltList<HabitPropriety>? get proprieties; // Liste des propriétés

  // Constructor
  Habit._();
  factory Habit([void Function(HabitBuilder) updates]) = _$Habit;

  // Serializer
  static Serializer<Habit> get serializer => _$habitSerializer;

  //--------------------------------------------------------//

  // Convertir un Habit en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'commandeUid': commandeUid,
      'modeleUid': modeleUid,
      'name': name,
      'details': details,
      'image': image,
      'price': price,
      'createdAt': createdAt, // Stocké en String
      'updatedAt': updatedAt, // Stocké en String
      // Serialize les propriétés
      //'proprieties': proprieties?.map((prop) => prop.toJson()).toList(),
    };
  }

  // Créer un Habit à partir d'une Map SQLite
  static Habit fromMap(Map<String, dynamic> map) {
    return Habit((b) => b
          ..id = map['id'] as int?
          ..uid = map['uid'] as String?
          ..commandeUid = map['commandeUid'] as String?
          ..modeleUid = map['modeleUid'] as String?
          ..name = map['name'] as String?
          ..details = map['details'] as String?
          ..image = map['image'] as String?
          ..price = map['price'] as double?
          ..createdAt = map['createdAt'] as String?
          ..updatedAt = map['updatedAt'] as String?
          // Deserialize les propriétés
          ..proprieties = ListBuilder(
              []) /*ListBuilder((map['proprieties'] as List).map((propJson) =>
          HabitPropriety.fromJson(propJson as Map<String, dynamic>)))*/
        );
  }

  // Serialization
  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Habit.serializer, this)
        as Map<String, dynamic>;
  }

  static Habit fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Habit.serializer, json)!;
  }
}
