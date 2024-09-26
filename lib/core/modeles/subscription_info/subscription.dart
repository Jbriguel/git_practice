import 'package:cloud_firestore/cloud_firestore.dart';

/*
Liste des Permissions : 
**************************
add_multiple_workshops : Ajouter plusieurs ateliers.
manage_employees : Gestion des employés.
manage_managers : Gestion des managers.
access_dashboard : Accès au tableau de bord.
data_synchronization : Synchronisation des données.
restore_local_database : Restauration de la base de données locale.
export_client_data : Exporter les données clients.
export_order_data : Exporter les données commandes.
add_employee : Ajouter un employé.
add_manager : Ajouter un manager.

*/
class Subscription {
  final DateTime createdAt;
  final String key;
  final String name;
  final int? delay;
  final List<String> permissions;

  Subscription({
    required this.createdAt,
    required this.key,
    required this.name,
    required this.delay,
    required this.permissions,
  });

  /// Convertir un Map en une instance de Subscription
  factory Subscription.fromMap(Map<String, dynamic> data) {
    return Subscription(
      createdAt: (data['createdAt'] as Timestamp)
          .toDate(), // Convertir le Timestamp Firestore en DateTime
      key: data['key'] as String,
      name: data['name'] as String,
      delay: data['delay'] != null ? int.parse("${data['delay']}") : null,
      permissions: List<String>.from(
          data['permissions'] ?? []), // Convertir la liste de permissions
    );
  }

  /// Convertir une instance de Subscription en Map
  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'key': key,
      'name': name,
      'delay': delay,
      'permission': permissions,
    };
  }

  @override
  String toString() {
    return 'Subscription(createdAt: $createdAt, key: $key, name: $name, permissions: $permissions)';
  }
}
