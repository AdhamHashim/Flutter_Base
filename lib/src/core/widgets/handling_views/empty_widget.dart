import 'package:flutter/material.dart';
import '../../../config/res/config_imports.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/text_style_extensions.dart';
import '../../extensions/widgets/margin_extention.dart';
import '../../extensions/widgets/padding_extension.dart';

class EmptyWidget extends StatelessWidget {
  final String path;
  final String title;
  final String desc;
  const EmptyWidget({
    super.key,
    required this.path,
    required this.desc,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppMargin.mH12,
      children: [
        Image.asset(
          path,
          width: context.width * .6,
          height: context.height * .25,
        ),
        Text(title, style: const TextStyle().setMainTextColor.s13.medium),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: const TextStyle().setSecondryColor.s11.regular,
        ).paddingSymmetric(horizontal: AppPadding.pW14),
      ],
    ).paddingAll(AppPadding.pH10).marginTop(context.height * .1);
  }
}
