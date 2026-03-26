import '../../../../config/res/config_imports.dart';

enum NotificationAccent { success, warning, info }

class NotificationEntity {
  final String id;
  final String type;
  final String title;
  final String body;
  final String createdAt;
  final int read;
  final Map<String, dynamic> data;
  final NotificationAccent accent;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.read,
    required this.data,
    this.accent = NotificationAccent.info,
  });

  static NotificationAccent _accentFromType(String type) {
    final t = type.toLowerCase();
    if (t.contains('expense') || t == 'warning') {
      return NotificationAccent.warning;
    }
    if (t.contains('savings') || t.contains('goal')) {
      return NotificationAccent.info;
    }
    if (t.contains('achievement') || t.contains('success')) {
      return NotificationAccent.success;
    }
    return NotificationAccent.info;
  }

  factory NotificationEntity.initial() => const NotificationEntity(
    id: SkeltonizerManager.short,
    type: SkeltonizerManager.short,
    title: SkeltonizerManager.short,
    body: SkeltonizerManager.medium,
    createdAt: SkeltonizerManager.medium,
    read: 1,
    data: {},
    accent: NotificationAccent.info,
  );

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type']?.toString() ?? '';
    return NotificationEntity(
      id: json['id']?.toString() ?? '',
      type: typeStr,
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      data: json['data'] is Map<String, dynamic>
          ? Map<String, dynamic>.from(json['data'] as Map)
          : {},
      createdAt: json['created_at']?.toString() ?? '',
      read: int.tryParse(json['read']?.toString() ?? '') ?? 0,
      accent: _accentFromType(typeStr),
    );
  }

  Map<String, dynamic> get toMap => {
    'id': id,
    'type': type,
    'title': title,
    'body': body,
    'data': data,
    'created_at': createdAt,
    'read': read,
  };

  bool get isUnread => read == 0;
}
