import 'dart:convert';
import 'package:atelier_so/core/modeles/data_commande/habit/habit.dart';
import 'package:atelier_so/core/modeles/serializers/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'commande.g.dart';

abstract class Commande implements Built<Commande, CommandeBuilder> {
  // Fields
  int? get id;
  String? get uid;
  String? get clientUid;
  String? get details;
  double? get price; // Prix total de la commande
  double? get advance; // Avance donnée par le client
  String get deliveryDate; // Stocké sous forme de String
  String? get status; // status de la commande
  String get createdAt; // Stocké sous forme de String
  String? get updatedAt; // Stocké sous forme de String
  @BuiltValueField(
    wireName: 'habits',
    serialize: false,
  )
  
  BuiltList<Habit>? get habits; // Liste des habits liés à la commande

  // Constructor
  Commande._();
  factory Commande([void Function(CommandeBuilder) updates]) = _$Commande;

  // Serializer
  static Serializer<Commande> get serializer => _$commandeSerializer;

  //--------------------------------------------------------//

  // Convertir une Commande en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'clientUid': clientUid,
      'details': details,
      'price': price,
      'advance': advance,
      'status': "en_attente",
      'deliveryDate': deliveryDate, // Stocké en String
      'createdAt': createdAt, // Stocké en String
      'updatedAt': updatedAt, // Stocké en String
      // Serialize les habits dans une liste de Map<String, dynamic>
      //'habits': habits?.map((habit) => habit.toMap()).toList(),
    };
  }

  // Créer une Commande à partir d'une Map SQLite
  static Commande fromMap(Map<String, dynamic> map) {
    return Commande((b) => b
      ..id = map['id'] as int?
      ..uid = map['uid'] as String?
      ..clientUid = map['clientUid'] as String?
      ..details = map['details'] as String?
      ..price = map['price'] as double?
      ..advance = map['advance'] as double?
      ..deliveryDate = map['deliveryDate'] as String?
      ..status = map['status'] as String? // Directement stocké en String
      ..createdAt = map['createdAt'] as String? // Directement stocké en String
      ..updatedAt = map['updatedAt'] as String?
      // Deserialize les habits depuis la liste de Map<String, dynamic>
      ..habits = ListBuilder((map['habits'] as List)
          .map((habitMap) => Habit.fromMap(habitMap as Map<String, dynamic>))));
  }

  // Serialization
  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Commande.serializer, this)
        as Map<String, dynamic>;
  }

  static Commande fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Commande.serializer, json)!;
  }
}
