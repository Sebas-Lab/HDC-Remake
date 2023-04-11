import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<dynamic>> _loadHymnsFromJson() async {
  String jsonString = await rootBundle.loadString('assets/sample_hymns.json');
  return jsonDecode(jsonString);
}
