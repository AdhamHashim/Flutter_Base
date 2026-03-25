part of '../imports/view_imports.dart';

class _MoreTabHeaderWidget extends StatelessWidget {
  const _MoreTabHeaderWidget();

  @override
  Widget build(BuildContext context) {
    context.locale;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.cardFill,
        boxShadow: [AppColors.containerShadow],
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: AppSize.sH70,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              LocaleKeys.settingsTitle,
              textAlign: TextAlign.start,
              textDirection: context.isArabic
                  ? ui.TextDirection.rtl
                  : ui.TextDirection.ltr,
              style:
                  const TextStyle().setMainTextColor.s18.semiBold.setFontFamily,
            ),
          ).paddingSymmetric(horizontal: AppPadding.pW20),
        ),
      ),
    );
  }
}
