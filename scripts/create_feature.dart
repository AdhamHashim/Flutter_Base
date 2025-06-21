import 'dart:io';
import 'package:flutter/foundation.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    if (kDebugMode) {
      print("❌ Please provide a feature name!");
      print("Usage: dart scripts/create_feature.dart feature_name");
    }
    return;
  }

  final featureName = args[0];
  final basePath = "lib/features/$featureName";
  if (kDebugMode) {
    print("🚀 Creating feature: $featureName...");
  }
  final folders = [
    "$basePath/data/models", 
    "$basePath/data/data_sources",   
    "$basePath/presentation/screens",
    "$basePath/presentation/widgets",
    "$basePath/presentation/cubits",
  ];

  final files = {
    "$basePath/data/models/${featureName}_model.dart": "", 
    "$basePath/data/datasources/${featureName}_data_source.dart": "",  
    "$basePath/presentation/screens/${featureName}_screen.dart": "",
    "$basePath/presentation/widgets/${featureName}_body.dart": "",
    "$basePath/presentation/cubit/${featureName}_cubit.dart": "",
    "$basePath/presentation/cubit/${featureName}_state.dart": "",
  };

  // Create folders
  for (var folder in folders) {
    Directory(folder).createSync(recursive: true);
  }

  // Create files
  for (var file in files.keys) {
    File(file).createSync(recursive: true);
  }
  if (kDebugMode) {
    print("✅ Feature '$featureName' created successfully!");
  }
}
