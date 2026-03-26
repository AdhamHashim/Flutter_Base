import '../../../../core/extensions/string_extension.dart';

/// POST body for send-sms-to-new-phone and fields reused for verify-new payload.
class ChangePhoneSmsBody {
  const ChangePhoneSmsBody({
    required this.countryCode,
    required this.phone,
  });

  final String countryCode;
  final String phone;

  Map<String, dynamic> toJson() => {
        'country_code': countryCode.toEnglishNumbers(),
        'phone': phone.toEnglishNumbers(),
      };
}

class ChangePhoneVerifyNewBody {
  const ChangePhoneVerifyNewBody({
    required this.countryCode,
    required this.phone,
    required this.code,
  });

  final String countryCode;
  final String phone;
  final String code;

  Map<String, dynamic> toJson() => {
        'country_code': countryCode.toEnglishNumbers(),
        'phone': phone.toEnglishNumbers(),
        'code': code.toEnglishNumbers(),
      };
}

String changePhoneMaskedDisplay(String raw) {
  final digits = raw.replaceAll(RegExp(r'\D'), '');
  if (digits.length < 4) {
    return raw.isEmpty ? '----' : raw;
  }
  return '•••• ${digits.substring(digits.length - 4)}';
}
