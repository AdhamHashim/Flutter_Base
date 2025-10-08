import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import '../../../config/res/config_imports.dart';
import '../../extensions/context_extension.dart';
import '../../extensions/text_style_extensions.dart';
import '../../helpers/arabic_numbers_formatter.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.suffixIcon,
    this.subTitle,
    this.prefixIcon,
    this.suffix,
    this.prefix,
    this.hint,
    this.errorText,
    this.hintStyle,
    this.labelStyle,
    this.labelFF,
    this.style,
    this.isMandatory = false,
    this.isOptionalOrHasSubTitle = false,
    this.isBordered = true,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.fillColor,
    this.keyboardType,
    this.borderRadius,
    this.debounceOnChanged = true,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.contentPadding,
    this.readOnly = false,
    this.textAlign,
    this.hintTextDirection,
    this.textDirection,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.decoration,
    this.maxLines = 1,
    this.minLines = 1,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.suffixIconMaxHeight,
  }) : label = null;
  // factory with non border
  const AppTextField.withoutBorder({
    super.key,
    this.suffixIcon,
    this.prefixIcon,
    this.suffix,
    this.subTitle,
    this.prefix,
    this.hint,
    this.errorText,
    this.hintStyle,
    this.style,
    this.labelStyle,
    this.labelFF,
    this.isMandatory = false,
    this.isOptionalOrHasSubTitle = false,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.fillColor,
    this.keyboardType,
    this.borderRadius,
    this.debounceOnChanged = true,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.contentPadding,
    this.readOnly = false,
    this.textAlign,
    this.hintTextDirection,
    this.textDirection,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.decoration,
    this.label,
    this.maxLines = 1,
    this.minLines = 1,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.suffixIconMaxHeight,
  }) : isBordered = false;

  const AppTextField.withLabel({
    super.key,
    this.suffixIcon,
    this.prefixIcon,
    this.suffix,
    this.prefix,
    this.subTitle,
    this.hint,
    this.errorText,
    this.hintStyle,
    this.style,
    this.labelStyle,
    this.decoration,

    /// Label Text Font Family
    this.labelFF,
    this.isOptionalOrHasSubTitle = false,
    this.isMandatory = false,
    this.isBordered = true,
    required this.label,
    this.fillColor,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textAlign,
    this.hintTextDirection,
    this.textInputAction = TextInputAction.next,
    this.readOnly = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.inputFormatters = const [],
    this.contentPadding,
    this.textDirection,
    this.validator,
    this.debounceOnChanged = true,
    this.obscureText = false,
    this.onChanged,
    this.borderRadius,
    this.onSaved,
    this.onTap,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.maxLines = 1,
    this.minLines = 1,
    this.suffixIconMaxHeight,
  }) : assert(label != null, 'Label must not be null');

  final int maxLines, minLines;

  final String? label;
  final String? subTitle;
  final String? hint, errorText;
  final TextStyle? hintStyle, style, labelStyle;
  final String? labelFF;
  final Color? fillColor;
  final TextAlign? textAlign;
  final TextDirection? hintTextDirection, textDirection;
  final bool readOnly,
      isOptionalOrHasSubTitle,
      isMandatory,
      isBordered,
      debounceOnChanged,
      obscureText;
  final FocusNode? focusNode;
  final AutovalidateMode autovalidateMode;
  final Widget? suffixIcon, prefixIcon, suffix, prefix;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final List<TextInputFormatter> inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged, onSaved;
  final void Function()? onTap;
  final MainAxisAlignment mainAxisAlignment;
  final BoxDecoration? decoration;
  final double? borderRadius;
  final double? suffixIconMaxHeight;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _debouncer = PublishSubject<String>();

  @override
  void initState() {
    if (widget.onChanged != null) {
      _debouncer.stream
          .debounceTime(const Duration(milliseconds: 300))
          .listen(widget.onChanged);
    }
    super.initState();
  }

  @override
  void dispose() {
    _debouncer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSize.sH8,
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: widget.label,
                    style: context.textStyle.s14.regular.setBlackColor),
                if (widget.isMandatory)
                  TextSpan(
                    text: ' *',
                    style: context.textStyle.s12.regular.setErrorColor,
                  ),
                if (widget.isOptionalOrHasSubTitle)
                  TextSpan(
                    text: widget.subTitle != null
                        ? ' ${widget.subTitle}'
                        : ' ("{LocaleKeys..tr("})',
                    style: context.textStyle.s12.regular.setHintColor,
                  ),
              ],
            ),
          ),
        Container(
          alignment: Alignment.center,
          decoration: widget.decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                // color: ColorManager.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(0, 4),
                    blurRadius: 124,
                    spreadRadius: 0,
                  ),
                ],
              ),
          child: TextFormField(
            obscureText: widget.obscureText,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            focusNode:
                widget.readOnly ? AlwaysDisabledFocusNode() : widget.focusNode,
            controller: widget.controller,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            textDirection: widget.textDirection,
            validator: widget.validator,
            onChanged: widget.onChanged != null && widget.debounceOnChanged
                ? _debouncer.add
                : widget.onChanged,
            onSaved: widget.onSaved,
            maxLines: widget.maxLines,
            onFieldSubmitted: widget.onSaved,
            inputFormatters: [
              ArabicNumbersFormatter(),
              ...widget.inputFormatters,
            ],
            autovalidateMode: widget.autovalidateMode,
            keyboardType: widget.keyboardType,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: widget.textInputAction,
            style: widget.style ?? context.textStyle.s14.regular.setHintColor,
            textAlign: widget.textAlign ?? TextAlign.start,
            decoration: InputDecoration(
              errorMaxLines: 2,
              errorStyle: context.textStyle.s12.regular.setErrorColor,
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 0.h,
                  ),
              hintText: widget.hint,
              hintTextDirection: widget.hintTextDirection,
              hintStyle: widget.hintStyle ??
                  context.textStyle.s12.regular.setHintColor,
              errorText: widget.errorText,
              fillColor: widget.fillColor ?? Colors.white,
              filled: true,
              border: widget.isBordered
                  ? OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 12.r),
                      borderSide: BorderSide(
                          color: widget.isBordered
                              ? AppColors.hintText
                              : Colors.transparent,
                          width: .5),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
              enabledBorder: widget.isBordered
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.isBordered
                              ? AppColors.hintText
                              : Colors.transparent,
                          width: .5),
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 12.r),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
              focusedBorder: widget.isBordered
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.isBordered
                              ? AppColors.hintText
                              : Colors.transparent,
                          width: .5),
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 12.r),
                    )
                  : null,
              errorBorder: widget.isBordered
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        width: .5,
                        color: AppColors.error.withValues(alpha: 0.65),
                      ),
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 12.r),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        width: .5,
                        color: AppColors.error.withValues(alpha: 0.65),
                      ),
                    ),
              suffixIcon: widget.suffixIcon != null
                  ? Padding(
                      padding: EdgeInsetsDirectional.only(end: AppPadding.pW12),
                      child: widget.suffixIcon,
                    )
                  : null,
              suffixIconConstraints: BoxConstraints(
                minHeight: 24.w,
                minWidth: 24.w,
                maxHeight: widget.suffixIconMaxHeight ?? 24.w,
              ),
              prefixIconConstraints: BoxConstraints(
                minHeight: 24.w,
                minWidth: 40.w,
                maxHeight: 24.w,
              ),
              prefixIcon: widget.prefixIcon,
              suffix: widget.suffix,
              prefix: widget.prefix,
            ),
          ),
        )
      ],
    );
  }
}
