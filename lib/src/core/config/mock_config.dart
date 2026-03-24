/// Mock Data Configuration — Single Switch Point
///
/// Controls whether the app uses mock data or real API.
/// Driven by `--dart-define=USE_MOCK=true` at build time.
///
/// Usage:
/// ```bash
/// flutter run --dart-define=USE_MOCK=true     # mock mode (design review)
/// flutter run --dart-define=USE_MOCK=false    # real API (default)
/// flutter run                                 # default = false (real API)
/// ```
class MockConfig {
  MockConfig._();

  /// Read from --dart-define=USE_MOCK=true|false
  /// Default: false (real API)
  static const bool useMock =
      bool.fromEnvironment('USE_MOCK', defaultValue: false);

  /// Simulated network latency in mock mode
  static const Duration mockDelay = Duration(milliseconds: 800);

  /// Helper to simulate async loading (call in mock path of cubits)
  static Future<void> simulateDelay() async {
    if (useMock) await Future.delayed(mockDelay);
  }
}
