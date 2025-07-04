import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/language/locale_keys.g.dart';
import 'package:flutter_base/src/config/res/assets.gen.dart';
import 'package:flutter_base/src/core/extensions/context_extension.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';

import '../../config/res/app_sizes.dart';

class NotContainData extends StatelessWidget {
  final double? width, height;
  final String? errorMessage;
  final Widget? placeHolder;
  const NotContainData({
    super.key,
    this.width,
    this.height,
    this.errorMessage,
    this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppMargin.mH10,
      children: [
        Visibility(
          visible: placeHolder != null,
          replacement: AppAssets.lottie.data.notFound2.lottie(
            width: width ?? context.width * .8,
            height: height != null ? (height! * .8) : context.height * .3,
          ),
          child: placeHolder ?? const SizedBox.shrink(),
        ),
        Text(
          errorMessage ?? LocaleKeys.errorExceptionNotContain,
          style: const TextStyle().setPrimaryColor.s12.medium,
        ),
      ],
    );
  }
}
