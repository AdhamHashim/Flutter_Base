/// Static UI-only values until subscriptions API exists.
class SubscriptionUiConstants {
  SubscriptionUiConstants._();

  static const int trialDaysRemaining = 15;
  static const int monthlyPriceSar = 29;
  static const int yearlyPriceSar = 290;

  /// UI-only trial end date until subscriptions API exists.
  static final DateTime trialEndsAt = DateTime(2026, 1, 21);
}
