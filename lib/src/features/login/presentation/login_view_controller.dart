import 'package:flutter/material.dart';

import '../../../core/extensions/form_mixin.dart';

class LoginViewController with FormMixin {
  LoginViewController();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
  }
}

class LoginPinViewController {
  LoginPinViewController();

  final TextEditingController pinController = TextEditingController();

  void dispose() {
    pinController.dispose();
  }
}
