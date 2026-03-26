import 'package:flutter/material.dart';

import '../../../../core/extensions/form_mixin.dart';

class RegisterParams with FormMixin {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final ValueNotifier<String?> selectedType = ValueNotifier(null);

  void dispose() {
    phoneController.dispose();
    usernameController.dispose();
    nicknameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    selectedType.dispose();
  }
}
