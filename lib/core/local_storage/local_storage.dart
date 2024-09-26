import 'dart:convert';
import 'package:atelier_so/core/modeles/user/user.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LocalAuthType {
  password,
  fingerprint,
}

enum SharedPreferencesType {
  string,
  int,
  double,
  bool,
  stringList,
  object,
}

@singleton
class AppLocalData extends ChangeNotifier {
  // late SharedPreferences instance;
  late SharedPreferences instance;

  AppLocalData() {
    init();
  }

  Future<void> init() async {
    instance = await SharedPreferences.getInstance();
    notifyListeners();
  }

  Future<AppLocalData> getInstance() async {
    instance = await SharedPreferences.getInstance();
    return AppLocalData();
  }

  // Définition des clés prédéfinies
  String kOpenKey = 'AppDejaOpen';
  String kUserKey = 'atelierSoUser';

  ///pour le key encrypter qui sera decoder pour obtenir le [SubscriptionInfos]
  String kCurrentSubscriptionEncryptedKey = 'ASABN_current_encrypted_KEY';
  ///Pour les details de l'abonnement en cours [ Subscription ]
  String kSubscriptionAndPermissionsKey =
      'ASABN_subscriptionAndPermissions_KEY';

  String kBoolValueKey = 'boolValue';
  String kStringListValueKey = 'stringListValue';
  String kObjectValueKey = 'objectValue';

  // Sauvegarde d'une valeur dans les préférences partagées
  void set<T>(String key, T value, SharedPreferencesType type) {
    switch (type) {
      case SharedPreferencesType.string:
        instance.setString(key, value as String);
        break;
      case SharedPreferencesType.int:
        instance.setInt(key, value as int);
        break;
      case SharedPreferencesType.double:
        instance.setDouble(key, value as double);
        break;
      case SharedPreferencesType.bool:
        instance.setBool(key, value as bool);
        break;
      case SharedPreferencesType.stringList:
        instance.setStringList(key, value as List<String>);
        break;
      case SharedPreferencesType.object:
        final jsonString = jsonEncode(value);
        instance.setString(key, jsonString);
        break;
    }
  }

  // Récupération d'une valeur à partir des préférences partagées
  T? get<T>(String key,
      {SharedPreferencesType type = SharedPreferencesType.string}) {
    switch (type) {
      case SharedPreferencesType.string:
        return instance.getString(key) as T?;
      case SharedPreferencesType.int:
        return instance.getInt(key) as T?;
      case SharedPreferencesType.double:
        return instance.getDouble(key) as T?;
      case SharedPreferencesType.bool:
        return instance.getBool(key) as T?;
      case SharedPreferencesType.stringList:
        return instance.getStringList(key) as T?;
      case SharedPreferencesType.object:
        final jsonString = instance.getString(key);
        if (jsonString != null) {
          return jsonDecode(jsonString) as T?;
        }
        return null;
    }
  }

  Future<void> remove(String key) async {
    await instance.remove(key);
  }

  Future<void> clear() async {
    await instance.clear();
  }

  doDeconnexion(String lastEmail) async {
    await init();
    clear();
    set(kOpenKey, true, SharedPreferencesType.bool);
    //set(kLastEmailKey, lastEmail, SharedPreferencesType.string);
  }

  void saveAppOpen(bool dejaOpen) async {
    set(kOpenKey, true, SharedPreferencesType.bool);
  }

  bool getAppOpen() {
    return get<bool>(kOpenKey, type: SharedPreferencesType.bool) ?? false;
  }

  //###############################
}
