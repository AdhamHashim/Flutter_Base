import 'package:flutter/material.dart';

import '../entity/profile_entity.dart';

class ProfileEditViewController {
  ProfileEditViewController({required ProfileEntity initial}) {
    usernameController.text = initial.username;
    nicknameController.text = initial.nickname;
    selectedGender.value = initial.genderKey;
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final ValueNotifier<String?> selectedGender = ValueNotifier<String?>(null);

  void dispose() {
    usernameController.dispose();
    nicknameController.dispose();
    selectedGender.dispose();
  }
}
