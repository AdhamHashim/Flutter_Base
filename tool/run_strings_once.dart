// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import '../generate/strings/main.dart' as gen;

/// One-shot locale generation (no file watcher). Run: dart run tool/run_strings_once.dart
Future<void> main() async {
  const path = 'assets/translations/lang.json';
  final file = File(path);
  final jsonMap = json.decode(file.readAsStringSync()) as Map<String, dynamic>;
  final jsonEnMap = await gen.generateJsonTranslate(lang: 'en', jsonMap: jsonMap);
  await gen.generateJsonTranslate(lang: 'ar', jsonMap: jsonMap);
  await gen.generateAppStrings(jsonEnMap);
  print('Locale files updated.');
}
