import 'package:uuid/uuid.dart';

class UIDGenerator {
  final Uuid _uuid = Uuid();

  // Générer un UID unique
  String generateUID() {
    return _uuid.v4();
  }
}
