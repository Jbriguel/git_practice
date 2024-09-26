import 'dart:math';

String generateUniqueIdentify(DateTime date) {
  final Random random = Random();
  final String prefix = 'AS';
  
  // Obtenir les deux premiers chiffres de l'année
  String yearPrefix = date.year.toString().substring(2, 4);
  
  // Obtenir la première lettre du mois
  List<String> monthAbbreviations = [
    'J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'
  ];
  String monthLetter = monthAbbreviations[date.month - 1];
  
  // Générer une partie aléatoire de 5 caractères
  final String characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  String randomString = String.fromCharCodes(
    Iterable.generate(5, (_) => characters.codeUnitAt(random.nextInt(characters.length))),
  );
  
  // Combiner tous les éléments pour créer l'identifiant complet
  return '$prefix$yearPrefix$monthLetter$randomString';
}

void main() {
  DateTime currentDate = DateTime.now(); // Utiliser la date actuelle
  String identify = generateUniqueIdentify(currentDate);
  print('Generated Identify: $identify'); // Exemple: AS2408G5H9K
}
