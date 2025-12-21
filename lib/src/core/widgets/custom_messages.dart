import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../generated/locale_keys.g.dart';
import '../../config/res/config_imports.dart';
import '../extensions/base_state.dart';
import '../extensions/text_style_extensions.dart';
import '../navigation/navigator.dart';

class MessageUtils {
  static void showSnackBar({
    BuildContext? context,
    required BaseStatus baseStatus,
    required String message,
  }) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(message, style: const TextStyle().setWhiteColor.s11.medium),
      action: SnackBarAction(
        label: LocaleKeys.app_cancel.tr(context: context ?? Go.context),
        textColor: AppColors.white,
        onPressed: () {
          ScaffoldMessenger.of(context ?? Go.context).clearSnackBars();
        },
      ),
      backgroundColor: baseStatus == BaseStatus.error
          ? AppColors.secondary
          : AppColors.primary,
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    );
    ScaffoldMessenger.of(context ?? Go.context).showSnackBar(snackBar);
  }
}
