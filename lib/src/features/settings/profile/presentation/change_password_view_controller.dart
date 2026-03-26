import 'package:flutter/material.dart';

class ChangePasswordViewController {
  final TextEditingController currentController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void dispose() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();
  }
}
