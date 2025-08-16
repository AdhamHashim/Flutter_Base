import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../config/res/config_imports.dart';
import '../../extensions/context_extension.dart';
import '../../extensions/text_style_extensions.dart';
import 'custom_animated_button.dart';

class LoadingButton extends StatelessWidget {
  final GlobalKey<CustomButtonState> btnKey;
  final String title;
  final Function() onTap;
  final Color? textColor;
  final Color? color;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final BorderSide borderSide;

  const LoadingButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
    this.textColor,
    this.borderSide = BorderSide.none,
    this.borderRadius,
    this.margin,
    this.borderColor,
    this.fontFamily,
    this.fontSize,
    this.width,
    this.height,
    this.fontWeight,
    required this.btnKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: AppMargin.mH10),
      child: CustomButtonAnimation(
        key: btnKey,
        onTap: onTap,
        width: width ?? context.width,
        minWidth: AppSize.sW50,
        height: height ?? AppSize.sH44,
        color: color ?? AppColors.buttonColor,
        borderRadius: borderRadius ?? AppCircular.r5,
        disabledColor: color ?? AppColors.buttonColor,
        borderSide: borderSide,
        loader: Container(
          padding: EdgeInsets.all(AppPadding.pH10),
          child: SpinKitFoldingCube(
            color: AppColors.white,
            size: AppSize.sH20,
          ),
        ),
        child: Text(
          title,
          style: const TextStyle().setWhiteColor.s15.medium,
        ),
      ),
    );
  }
}
