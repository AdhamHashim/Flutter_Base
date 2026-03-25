import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../extensions/text_style_extensions.dart';
import '../../icon_widget.dart';

class DefaultTextField extends StatefulWidget {
  final String? title;
  final bool secure;
  final TextInputType inputType;
  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  final String? label;
  final Function(String?)? onSubmitted;
  final Color? fillColor;
  final Widget? prefixIcon;
  final bool readOnly;
  final bool filled;
  final int? maxLength;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final GestureTapCallback? onTap;
  final String? suffixText;
  final TextInputAction action;
  final bool autoFocus;
  final FocusNode? focusNode;
  final Widget? prefixWidget;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final bool? isPassword;
  final int? maxLines;
  final bool? hasBorderColor;
  final Color? borderColor;
  final void Function(String?)? onChanged;
  final bool closeWhenTapOutSide;
  final TextStyle? style;
  final void Function()? onEditingComplete;
  final BorderRadius? borderRadius;

  const DefaultTextField({
    super.key,
    this.title,
    this.borderRadius,
    this.secure = false,
    this.inputType = TextInputType.text,
    this.borderColor,
    this.onTap,
    this.controller,
    this.contentPadding,
    this.closeWhenTapOutSide = true,
    this.hasBorderColor = true,
    this.validator,
    this.onEditingComplete,
    this.label,
    this.onSubmitted,
    this.isPassword = false,
    this.fillColor,
    this.inputFormatters,
    this.prefixIcon,
    this.prefixWidget,
    this.maxLength,
    this.filled = true,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.action = TextInputAction.next,
    this.focusNode,
    this.autoFocus = false,
    this.suffixText,
    this.suffixIcon,
    this.maxLines,
    this.onChanged,
    this.style,
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  late bool _isSecure;

  @override
  void initState() {
    super.initState();
    _isSecure = widget.isPassword == true;
  }

  @override
  void didUpdateWidget(covariant DefaultTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isPassword != true && widget.isPassword == true) {
      _isSecure = true;
    }
  }

  Widget? _resolveSuffixIcon() {
    if (widget.isPassword != true) return widget.suffixIcon;

    final toggle = Material(
      color: AppColors.white.withValues(alpha: 0),
      child: InkWell(
        onTap: () => setState(() => _isSecure = !_isSecure),
        borderRadius: BorderRadius.circular(AppCircular.r8),
        child: SizedBox(
          width: AppSize.sH44,
          height: AppSize.sH44,
          child: Center(
            child: IconWidget(
              icon: AppAssets.svg.wzeinIcons.eye.path,
              color: AppColors.hintText,
              height: AppSize.sH20,
              width: AppSize.sW20,
            ),
          ),
        ),
      ),
    );

    if (widget.suffixIcon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [widget.suffixIcon!, toggle],
      );
    }
    return toggle;
  }

  @override
  Widget build(BuildContext context) {
    final bool isLabel = widget.label != null;
    final bool isPwd = widget.isPassword == true;
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.isPassword == true ? _isSecure : widget.secure,
      obscuringCharacter: "*",
      onTap: widget.onTap,
      onTapOutside: (event) {
        if (widget.closeWhenTapOutSide == true) {
          FocusScope.of(context).unfocus();
        }
      },
      keyboardType: widget.inputType,
      autofillHints: _getAutoFillHints(widget.inputType),
      validator: widget.validator,
      maxLength: widget.maxLength,
      readOnly: widget.onTap != null ? true : widget.readOnly,
      textAlign: widget.textAlign!,
      maxLines: widget.inputType == TextInputType.multiline
          ? widget.maxLines ?? 7
          : 1,
      style: widget.style,
      onFieldSubmitted: widget.onSubmitted,
      textInputAction: widget.action,
      enableSuggestions: !isPwd,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autocorrect: !isPwd,
      autofocus: widget.autoFocus,
      focusNode: widget.autoFocus == true ? widget.focusNode : null,
      cursorColor: AppColors.main,
      onEditingComplete: widget.onEditingComplete,
      decoration: InputDecoration(
        isDense: true,
        errorMaxLines: 2,
        contentPadding: widget.contentPadding,
        counterText: ConstantManager.emptyText,
        filled: widget.filled,
        suffixText: widget.suffixText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _resolveSuffixIcon(),
        prefix: widget.prefixWidget,
        errorStyle: const TextStyle().setErrorColor.s12.regular,
        fillColor: widget.fillColor ?? Colors.white,
        hintText: widget.title,
        label: isLabel ? Text(widget.label!) : null,
        labelStyle: isLabel
            ? const TextStyle().setSecondryColor.s12.medium
            : null,
        hintStyle: const TextStyle().setHintColor.s13.regular,
        enabledBorder: OutlineInputBorder(
          borderRadius:
              widget.borderRadius ?? BorderRadius.circular(AppCircular.r10),
          borderSide: widget.hasBorderColor == true
              ? BorderSide(color: widget.borderColor ?? AppColors.border)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              widget.borderRadius ?? BorderRadius.circular(AppCircular.r10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius:
              widget.borderRadius ?? BorderRadius.circular(AppCircular.r10),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius:
              widget.borderRadius ?? BorderRadius.circular(AppCircular.r10),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}

List<String> _getAutoFillHints(TextInputType inputType) {
  if (inputType == TextInputType.emailAddress) {
    return [AutofillHints.email];
  } else if (inputType == TextInputType.datetime) {
    return [AutofillHints.birthday];
  } else if (inputType == TextInputType.phone) {
    return [AutofillHints.telephoneNumber];
  } else if (inputType == TextInputType.url) {
    return [AutofillHints.url];
  }
  return [AutofillHints.name, AutofillHints.username];
}
