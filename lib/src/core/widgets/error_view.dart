import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/context_extension.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import '../../config/res/app_sizes.dart';
import '../../config/res/assets.gen.dart';

class ErrorView extends StatelessWidget {
  final String error;
  final double? width, height;
  const ErrorView({
    super.key,
    required this.error,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? context.width,
      height: height ?? context.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppMargin.mH10,
        children: [
          AppAssets.lottie.error.error3.lottie(
            width: width ?? context.width * .8,
            height: height != null ? (height! * .8) : context.height * .3,
            fit: BoxFit.fill,
          ),
          Text(
            error,
            style: const TextStyle().setSecondryColor.s13.medium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
