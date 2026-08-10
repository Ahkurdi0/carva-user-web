import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<dynamic> loadJsonData(String fileName) async {
  final jsonStr = await rootBundle.loadString('test/assets/$fileName.json');
  return json.decode(jsonStr);
}
