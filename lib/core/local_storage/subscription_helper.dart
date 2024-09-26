import 'dart:convert';

import 'package:atelier_so/core/local_storage/local_storage.dart';
import 'package:atelier_so/core/modeles/subscription_info/subscription.dart';
import 'package:atelier_so/core/modeles/subscription_info/subscription_info.dart';

extension SubscriptionHelper on AppLocalData {
  //*************** [ SUBSCRIPTION ] ***************
  Future<void> setSubscription(Subscription subscription) async {
    Map<String, dynamic> jsonMap;

    final jsonString = jsonEncode(subscription.toMap());
    // SharedPreferences _instance = await getInstance();
    await instance.setString(kSubscriptionAndPermissionsKey, jsonString);
  }

  Future<Subscription?> getSubscription() async {
    // SharedPreferences _instance = await getInstance();
    final jsonString = instance.getString(kSubscriptionAndPermissionsKey);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return Subscription.fromMap(jsonMap);
    }
    return null;
  }

  Future<void> clearSubscription() async {
    // SharedPreferences _instance = await getInstance();
    await instance.remove(kSubscriptionAndPermissionsKey);
  }

  //*************** [ SUBSCRIPTION INFOS AND PERMISSIONS ] ***************

  Future<void> setSubscriptionKey(String subKey) async {
    // SharedPreferences _instance = await getInstance();
    await instance.setString(kCurrentSubscriptionEncryptedKey, subKey);
  }

  Future<String?> getSubscriptionKey() async {
    // SharedPreferences _instance = await getInstance();
    return instance.getString(kCurrentSubscriptionEncryptedKey);
  }

  Future<void> clearSubscriptionKey() async {
    // SharedPreferences _instance = await getInstance();
    await instance.remove(kCurrentSubscriptionEncryptedKey);
  }
}
