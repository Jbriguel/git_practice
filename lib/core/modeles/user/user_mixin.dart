import 'package:atelier_so/core/modeles/user/user.dart';

mixin UserMixin implements UserInterface {
  // Exemple de méthode commune à tous les utilisateurs
  @override
  String getFullName() {
    return '${prenom ?? ""} ${nom ?? ""}';
  }

  @override
  bool hasEntreprise() {
    return entrepriseId != null && entrepriseId!.isNotEmpty;
  }

  @override
  bool hasAtelier() {
    return atelierId != null && atelierId!.isNotEmpty;
  }

  @override
  String getRoleName() {
    return role;
  }

  @override
  bool get hasRole => role != null && role!.isNotEmpty;

  @override
  String get id => uid!;

  @override
  String get name => getFullName();
}
