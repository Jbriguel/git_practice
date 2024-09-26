import 'dart:convert';

import 'package:atelier_so/core/local_storage/local_storage.dart';
import 'package:atelier_so/core/modeles/employe/employe.dart';
import 'package:atelier_so/core/modeles/manager/manager.dart';
import 'package:atelier_so/core/modeles/owner/owner.dart';
import 'package:atelier_so/core/modeles/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension UserLocalHelper on AppLocalData {
  Future<void> setUser(UserInterface user) async {
    Map<String, dynamic> jsonMap;

    // Check the actual type of the user and serialize it accordingly
    if (user is Manager) {
      jsonMap = user.toJson();
    } else if (user is Owner) {
      jsonMap = user.toJson();
    } else if (user is Employe) {
      jsonMap = user.toJson();
    } else {
      throw Exception('Unknown user type');
    }

    // Add the role field to the JSON map for identification during deserialization
    jsonMap['role'] = user.role;

    final jsonString = jsonEncode(jsonMap);
    // SharedPreferences _instance = await getInstance();
    await instance.setString(kUserKey, jsonString);
  }

  Future<UserInterface?> getUser() async {
   // SharedPreferences _instance = await getInstance();
    final jsonString = instance.getString(kUserKey);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap =
          jsonDecode(jsonString) as Map<String, dynamic>;

      // Check the role and deserialize the correct type
      final String role = jsonMap['role'];

      switch (role) {
        case 'manager':
          return Manager.fromJson(jsonMap);
        case 'owner':
          return Owner.fromJson(jsonMap);
        case 'employe':
          return Employe.fromJson(jsonMap);
        default:
          throw Exception("Unknown user role: $role");
      }
    }
    return null;
  }

  Future<void> clearUser() async {
    // SharedPreferences _instance = await getInstance();
    await instance.remove(kUserKey);
  }
}
