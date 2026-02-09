import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Downloads an image from [url] to a temporary file and returns its path.
/// Returns null if the download fails or the URL is invalid.
Future<String?> downloadImageToTempFile(String url) async {
  if (url.isEmpty) return null;
  try {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) return null;
    final client = HttpClient();
    try {
      final request = await client.getUrl(uri);
      final response = await request.close();
      if (response.statusCode != 200) return null;
      final tempDir = await getTemporaryDirectory();
      final ext = _extensionFromUrl(url) ?? 'jpg';
      final file = File(
        '${tempDir.path}/notification_image_${DateTime.now().millisecondsSinceEpoch}.$ext',
      );
      await response.pipe(file.openWrite());
      return file.path;
    } finally {
      client.close();
    }
  } catch (_) {
    return null;
  }
}

String? _extensionFromUrl(String url) {
  final path = Uri.tryParse(url)?.path ?? '';
  final dot = path.lastIndexOf('.');
  if (dot != -1 && dot < path.length - 1) {
    final ext = path.substring(dot + 1).toLowerCase();
    if (ext.length <= 4 && RegExp(r'^[a-z0-9]+$').hasMatch(ext)) {
      return ext;
    }
  }
  return null;
}
