import 'package:atelier_so/core/modeles/abonnement/abonnement.dart';
import 'package:atelier_so/core/modeles/atelier/atelier.dart';
import 'package:atelier_so/core/modeles/data_commande/commande/commande.dart';
import 'package:atelier_so/core/modeles/data_commande/habit/habit.dart';
import 'package:atelier_so/core/modeles/data_commande/habit_propriety/habit_propriety.dart';
import 'package:atelier_so/core/modeles/data_modeles/modele/modele.dart';
import 'package:atelier_so/core/modeles/data_modeles/modele_propriety/mod_propriety.dart';
import 'package:atelier_so/core/modeles/data_modeles/propriety/propriety.dart';
import 'package:atelier_so/core/modeles/employe/employe.dart';
import 'package:atelier_so/core/modeles/entreprise/entreprise.dart';
import 'package:atelier_so/core/modeles/manager/manager.dart';
import 'package:atelier_so/core/modeles/owner/owner.dart';
import 'package:atelier_so/core/modeles/permission/permission.dart';
import 'package:atelier_so/core/modeles/user/user.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import '../client/client.dart';
import '../entreprise_abonnement/entreprise_abonnement.dart';
part 'serializers.g.dart'; // Le fichier généré par build_runner

@SerializersFor([
  ModPropriety,
  Modele,
  Propriety,
  Habit,
  HabitPropriety,
  Client,
  Employe,
  Manager,
  Owner,
  Entreprise,
  Atelier,
  Abonnement,
  Permission,
  EntrepriseAbonnement,
  Commande
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
