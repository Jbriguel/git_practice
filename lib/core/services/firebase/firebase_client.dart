// ignore_for_file: avoid_classes_with_only_static_members

import "dart:io" show Platform;
import "package:atelier_so/firebase_options.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/foundation.dart";

class FirebaseClient {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRmiZW1jWZNUvokE-0m97IKxUFxYyB-yM',
    appId: '1:365480623816:android:5a849b038d1bfba638effd',
    messagingSenderId: '365480623816',
    projectId: 'atelierso2024',
    storageBucket: 'atelierso2024.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCNVdJlojz0-l3gt5UtocBLmHbRogqrcCY',
    appId: '1:365480623816:ios:8756f2059340300a38effd',
    messagingSenderId: '365480623816',
    projectId: 'atelierso2024',
    storageBucket: 'atelierso2024.appspot.com',
    iosBundleId: 'com.example.atelierSo',
  );

  static late final FirebaseApp app;
  static late final FirebaseAuth auth;

  static Future<FirebaseClient> init() async {
    await initializeApp(); 
    return FirebaseClient();
  }

  static Future<void> initializeApp() async {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    } else {
      app = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      auth = FirebaseAuth.instanceFor(app: app);
    }
  }
}
