part of '../imports/shared_widgets_imports.dart';

class CustomTextFiled extends StatelessWidget {
  final String hint;
  final String? title;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;
  final String? Function(String?)? validator;
  final int? maxLines;
  final void Function()? onTap;
  final Color? fillColor;
  final bool hasBorder;
  final List<service.TextInputFormatter>? inputFormatters;
  final dynamic Function(String?)? onSubmitted;
  final void Function(String?)? onChanged;
  final bool readOnly;
  final FocusNode? focusNode;

  const CustomTextFiled({
    super.key,
    this.title,
    required this.hint,
    required this.textInputType,
    required this.textInputAction,
    required this.validator,
    this.onTap,
    this.focusNode,
    this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.onSubmitted,
    this.onChanged,
    this.maxLines,
    this.fillColor,
    this.inputFormatters,
    this.hasBorder = true,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppMargin.mH6,
      children: [
        Visibility(
          visible: title != null,
          replacement: const SizedBox.shrink(),
          child: Text(
            title ?? ConstantManager.emptyText,
            style: const TextStyle().setPrimaryColor.s13.bold,
          ),
        ),
        DefaultTextField(
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          controller: controller,
          borderColor: AppColors.border,
          hasBorderColor: hasBorder,
          inputType: textInputType,
          title: hint,
          filled: true,
          closeWhenTapOutSide: true,
          readOnly: readOnly,
          onSubmitted: onSubmitted,
          onTap: onTap,
          fillColor: fillColor,
          action: textInputAction,
          onChanged: onChanged,
          validator: validator,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppPadding.pW8,
            vertical: AppPadding.pH14,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          style: const TextStyle().setMainTextColor.s12.medium,
        ),
      ],
    );
  }
}
