
class SubscriptionInfo {
  final String entrepriseKey;
  final String abnKey;
  final String startedAt;
  final int delay;

  SubscriptionInfo({
    required this.entrepriseKey,
    required this.abnKey,
    required this.startedAt,
    required this.delay,
  });

  /// Convertir un Map en une instance de SubscriptionInfo
  factory SubscriptionInfo.fromMap(Map<String, dynamic> data) {
    return SubscriptionInfo(
      entrepriseKey: data['entreprise_key'] as String,
      abnKey: data['ABN_key'] as String,
      startedAt: data['startedAt'] as String,
      delay:
          int.parse(data['delay']), // Convertir la chaîne en int si nécessaire
    );
  }

  /// Convertir une instance de SubscriptionInfo en Map
  Map<String, dynamic> toMap() {
    return {
      'entreprise_key': entrepriseKey,
      'ABN_key': abnKey,
      'startedAt': startedAt,
      'delay': delay.toString(), // Convertir en String si nécessaire
    };
  }

  @override
  String toString() {
    return 'SubscriptionInfo(entrepriseKey: $entrepriseKey, abnKey: $abnKey, startedAt: $startedAt, delay: $delay)';
  }
}
