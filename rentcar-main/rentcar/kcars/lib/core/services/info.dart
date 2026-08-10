import 'package:kcars/envied/env.dart';

class Info {
  static final oneSignal = Env.oneSignal;
  // static final baseUrl = "http://192.168.0.105:3000/api/v1";
  static final baseUrl = Env.baseUrl;
  static final auth = "$baseUrl/auth";
  static final user = "$baseUrl/user";
  static final admin = "$baseUrl/admin";
  static final company = "$baseUrl/company";

  static final imageUrl = Env.imageUrl;
}
