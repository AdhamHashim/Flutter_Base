import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/res/app_sizes.dart';
import 'package:flutter_base/src/config/res/constants_manager.dart';
 
import '../../config/res/color_manager.dart';
import '../navigation/navigator.dart';

class MessageUtils {
  static void showSnackBar(
    String message, {
    Color? backgroundColor,
    Color? textColor,
    BuildContext? context,
  }) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: ConstantManager.snackbarDuration),
      content: Text(
        message,
        style:
            TextStyle(color: textColor ?? Colors.red, fontSize: FontSize.s14),
      ),
      backgroundColor: backgroundColor ?? AppColors.white,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context ?? Go.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }

  
}
