part of '../imports/view_imports.dart';

class ChangePhoneNewPhoneViewController with FormMixin {
  ChangePhoneNewPhoneViewController() {
    countryCodeController.text = '966';
  }

  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  ChangePhoneSmsBody toSmsBody() => ChangePhoneSmsBody(
        countryCode: countryCodeController.text.trim(),
        phone: phoneController.text.trim(),
      );

  void dispose() {
    countryCodeController.dispose();
    phoneController.dispose();
  }
}
