/// Type of notification to display when showing an FCM message locally.
/// Use [FcmNotificationDisplayType.text] for title + body only, or
/// [FcmNotificationDisplayType.image] for title + body + image.
enum FcmNotificationDisplayType {
  /// Show only title and body (no image).
  text,

  /// Show title, body, and a large image (e.g. Big Picture on Android).
  image,
}
