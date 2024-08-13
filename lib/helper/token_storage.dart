import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Tokens {
  static const storage =  FlutterSecureStorage();


  static Future<void> storeTokenLoggedIn(String token) async {
    await storage.write(key: "loggedIn", value: token);
  }
  static Future<void> storeTokenOnBoarding(String token) async {
    await storage.write(key: "first", value: token);
  }
  static Future<void> storeName(String token) async {
    await storage.write(key: "name", value: token);
  }
  static Future<String?> getTokenLoggedIn() async {
    return await storage.read(key: "loggedIn");
  }
  static Future<void> deleteTokenLoggedIn() async {
     await storage.delete(key: "loggedIn");
  }
  static Future<String?> getTokenOnBoarding() async {
    return await storage.read(key: "first");
  }
  static Future<void> deleteTokenOnBoarding() async {
     await storage.delete(key: "first");
  }
  static Future<String?> getName() async {
    return await storage.read(key: "name");
  }
  static Future<void> deleteName() async {
   await storage.delete(key: "name");
  }
  static Future<String?> removeToken() async {
    await storage.deleteAll();
    return null;
  }
}