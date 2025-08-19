part of 'config_imports.dart';

final GetIt injector = GetIt.instance;

class ConstantManager {
  static const String bundleId = 'com.flutter.app_name';
  static const String appName = 'Flutter_base';
  static const String fontFamily = 'IBM';
  static const String token = 'token';
  static const String projectName = 'Flutter_base';
  static const int splashTimer = 3000;
  static const String baseUrl = '';
  static const int paginationFirstPage = 1;
  static const int paginationPageSize = 10;
  static const String emptyText = '';
  static const int zero = 0;
  static const double zeroAsDouble = 0.0;
  static const int pinCodeFieldsCount = 4;
  static const int maxLines = 4;
  static const double snackbarElevation = 4;
  static const int snackbarDuration = 4;
  static const int connectTimeoutDuration = 180;
  static const int recieveTimeoutDuration = 180;
  static const double customImageSliderAsepctRatio = 3;
  static const String ar = 'ar';
  static const String en = 'en';
  static const String arabic = 'العربية';
  static const String english = 'English';
  static String saudiArabCountryCode =
      Languages.currentLanguage.languageCode == 'ar' ? '966+' : '+966';
  static const int pgSize = 10;
  static String platform = Platform.isAndroid ? 'android' : 'ios';
  static const int pgFirst = 1;
  static const double cardElevation = 1;
  static const int rateCount = 5;
  static const double minRateCount = 1;
}
