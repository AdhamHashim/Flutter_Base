import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/language/locale_keys.g.dart';
import 'package:flutter_base/src/config/res/app_sizes.dart';
import 'package:flutter_base/src/config/res/color_manager.dart';
import 'package:flutter_base/src/core/extensions/context_extension.dart';
import 'package:flutter_base/src/core/extensions/padding_extension.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_base/src/core/widgets/image_widgets/cached_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/validators.dart';

enum DropDownType { menu, bottomsheet }

mixin DefaultDropDownHelpers<T> {
  String Function(T?) get itemAsString;
  DropDownType get dropDownType;
  String Function(T)? get itemImage;
  BorderRadius? get borderRadius;
  Widget buildItem(BuildContext context, T item, bool isSelected) {
    return ListTile(
      title: Text(
        itemAsString(item),
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.black,
        ),
      ),
      leading: dropDownType == DropDownType.menu
          ? isSelected
              ? const Icon(Icons.check, color: AppColors.primary)
              : const SizedBox.shrink()
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSelected)
                  const Icon(Icons.check, color: AppColors.primary)
                else
                  25.szW,
                AppSize.sH10.szW,
                if (itemImage != null)
                  CachedImage(
                    url: itemImage!(item),
                    height: 20.h,
                    width: 30.w,
                    borderRadius: BorderRadius.circular(3),
                    fit: BoxFit.fill,
                  ).paddingSymmetric(horizontal: 2.w),
              ],
            ),
    );
  }

  Widget buildLoadingIndicator() => const Center(
        child: CupertinoActivityIndicator(),
      );

  PopupProps<T> buildPopupProps() {
    final constraints = BoxConstraints(
      maxHeight: 300.h,
      maxWidth: 400.w,
      minWidth: 350.w,
    );

    final searchFieldDecoration = InputDecoration(
      hintText: LocaleKeys.search,
      prefixIcon: const Icon(Icons.search),
      enabledBorder: dropDownType == DropDownType.bottomsheet
          ? const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            )
          : null,
    );

    if (dropDownType == DropDownType.menu) {
      return PopupProps.menu(
        showSearchBox: true,
        showSelectedItems: true,
        constraints: constraints,
        itemBuilder: buildItem,
        loadingBuilder: (_, __) => buildLoadingIndicator(),
        searchFieldProps: TextFieldProps(decoration: searchFieldDecoration),
        menuProps: const MenuProps(backgroundColor: AppColors.white),
      );
    } else {
      return PopupProps.bottomSheet(
        showSearchBox: true,
        showSelectedItems: true,
        constraints: constraints,
        itemBuilder: buildItem,
        loadingBuilder: (_, __) => buildLoadingIndicator(),
        searchFieldProps: TextFieldProps(decoration: searchFieldDecoration),
        bottomSheetProps:
            const BottomSheetProps(backgroundColor: AppColors.white),
      );
    }
  }

  InputDecoration buildInputDecoration({
    required Widget? prefixIcon,
    required String? hint,
  }) {
    final radius = borderRadius ?? BorderRadius.circular(AppCircular.r20);
    return InputDecoration(
      prefixIcon: prefixIcon,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: AppPadding.pW14,
      ),
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.border),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.border),
        borderRadius: radius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary),
        borderRadius: radius,
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary),
        borderRadius: radius,
      ),
    );
  }
}

class DefaultDropDownField<T> extends StatelessWidget
    with DefaultDropDownHelpers<T> {
  @override
  final String Function(T?) itemAsString;
  @override
  final DropDownType dropDownType;
  @override
  final String Function(T)? itemImage;
  @override
  final BorderRadius? borderRadius;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final T? selectedItem;
  final String? hint;
  final String? label;
  final Future<List<T>> Function(String)? asyncItems;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget Function(BuildContext, T?)? dropdownBuilder;

  const DefaultDropDownField({
    super.key,
    required this.itemAsString,
    this.asyncItems,
    this.validator,
    this.onChanged,
    this.hint,
    this.selectedItem,
    this.label,
    this.prefixIcon,
    this.dropdownBuilder,
    this.dropDownType = DropDownType.menu,
    this.itemImage,
    this.borderRadius,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppMargin.mH6,
      children: [
        if (label != null)
          Text(
            label!,
            style: const TextStyle().setPrimaryColor.s14.medium,
          ),
        Theme(
          data: context.theme.copyWith(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: DropdownSearch<T>(
            validator: validator ?? Validators.validateDropDown,
            onChanged: onChanged,
            selectedItem: selectedItem,
            clearButtonProps: const ClearButtonProps(
              color: Colors.black,
              isVisible: false,
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: const TextStyle(color: Colors.black),
              dropdownSearchDecoration: buildInputDecoration(
                prefixIcon: prefixIcon,
                hint: hint,
              ),
            ),
            dropdownBuilder: dropdownBuilder,
            compareFn: (item, selectedItem) => item == selectedItem,
            dropdownButtonProps: DropdownButtonProps(
              padding: EdgeInsets.zero,
              icon: suffixIcon ?? const Icon(Icons.arrow_drop_down),
              visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
            ),
            autoValidateMode: AutovalidateMode.onUserInteraction,
            itemAsString: itemAsString,
            popupProps: buildPopupProps(),
            asyncItems: asyncItems,
          ),
        ),
      ],
    );
  }
}
