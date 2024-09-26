import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pointycastle/asymmetric/api.dart';

class EncryptionService {

   Future<String> loadPrivateKey() async {
    return await rootBundle.loadString('ressources/keys/as_private.key');
  }

  Future<String> loadPublicKey() async {
    return await rootBundle.loadString('ressources/keys/as_public.pem');
  }
  Future<encrypt.Encrypter> initializeEncrypter() async {
    final publicPem =
        await rootBundle.loadString('ressources/keys/as_public.pem');
    final publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;

    final privatePem =
        await rootBundle.loadString('ressources/keys/as_private.key');
    final privateKey = RSAKeyParser().parse(privatePem) as RSAPrivateKey;

    print("publicKey: ${publicKey.toString()}");
    print("privateKey: $privateKey");
    // final privateKey =
    //     await parseKeyFromFile<RSAPrivateKey>("ressources/keys/as_private.key");
    // final publicKey =
    //     await parseKeyFromFile<RSAPublicKey>("ressources/keys/as_public.pem");

    return encrypt.Encrypter(
      encrypt.RSA(
          publicKey: publicKey,
          privateKey: privateKey,
          digest: encrypt.RSADigest.SHA256),
    );
  }

  Future<String> encrypter(String plainText) async {
    encrypt.Encrypter _encrypter = await initializeEncrypter();
    final encrypted = _encrypter.encrypt(plainText);
    return encrypted.base64;
  }

  Future<String> decrypter(String encryptedText) async {
    encrypt.Encrypter _encrypter = await initializeEncrypter();
    final encrypted = encrypt.Encrypted.fromBase64(encryptedText);
    return _encrypter.decrypt(encrypted);
  }

  Future<String> encryptMap(Map<String, dynamic> map) async {
    final jsonString = jsonEncode(map); // Convert Map to JSON string
    return await encrypter(jsonString); // Encrypt JSON string
  }

  Future<Map<String, dynamic>> decryptMap(String encryptedText) async {
    final jsonString = await decrypter(encryptedText); // Decrypt to JSON string
    return jsonDecode(jsonString); // Convert JSON string to Map
  }
}
