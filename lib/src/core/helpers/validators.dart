import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../navigation/navigator.dart';

class Validators {
  static String? validateEmpty(String? value, {String? fieldTitle}) {
    if (value == null || value.isEmpty) {
      return fieldTitle == null
          ? LocaleKeys.app_fill_field.tr(context: Go.context)
          : '${LocaleKeys.app_filedValidation.tr()} $fieldTitle';
    } else if (RegExp(r'[<>]').hasMatch(value)) {
      return LocaleKeys.app_scripInjectionValidate.tr(context: Go.context);
    }

    return null;
  }

  static String? validateEmail(String? value, {String? fieldTitle}) {
    if (value?.trim().isEmpty ?? true) {
      return fieldTitle == null
          ? LocaleKeys.app_fill_field.tr(context: Go.context)
          : '${LocaleKeys.app_filedValidation.tr()} $fieldTitle';
    } else if (RegExp(r'[<>]').hasMatch(value!)) {
      return LocaleKeys.app_scripInjectionValidate.tr(context: Go.context);
    } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.["
      r'a-zA-Z]+',
    ).hasMatch(value)) {
      return LocaleKeys.app_mail_validation.tr(context: Go.context);
    }
    return null;
  }

  static String? validatePhone(String? value, {String? fieldTitle}) {
    if (value?.trim().isEmpty ?? true) {
      return fieldTitle == null
          ? LocaleKeys.app_fill_field.tr(context: Go.context)
          : '${LocaleKeys.app_filedValidation.tr()} $fieldTitle';
    } else if (RegExp(r'[<>]').hasMatch(value!)) {
      return LocaleKeys.app_scripInjectionValidate.tr(context: Go.context);
    } else if (!RegExp(r'^\d{8,15}$').hasMatch(value)) {
      return LocaleKeys.app_phone_validation.tr(context: Go.context);
    }
    return null;
  }

  static String? noValidate(String value) {
    if (RegExp(r'[<>]').hasMatch(value)) {
      return LocaleKeys.app_scripInjectionValidate.tr(context: Go.context);
    } else {
      return null;
    }
  }

  static String? validateDropDown<T>(T? value, {String? fieldTitle}) {
    if (value == null) {
      return fieldTitle != null
          ? '${LocaleKeys.app_please.tr()} $fieldTitle'
          : LocaleKeys.app_fill_field.tr(context: Go.context);
    } else {
      return null;
    }
  }
}
