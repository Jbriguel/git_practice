abstract class UserInterface {
  String? get uid;
  String? get nom;
  String? get prenom;
  String? get email;
  String? get phone;
  String? get adresse;
  String? get password;
  String get role; // Peut être 'employe', 'manager', 'owner'
  String? get entrepriseId; // L'entreprise associée
  String? get atelierId; // L'atelier associé (si applicable)
  DateTime get createdAt;

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
