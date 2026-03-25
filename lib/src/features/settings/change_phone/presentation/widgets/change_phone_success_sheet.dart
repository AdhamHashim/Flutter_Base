part of '../imports/view_imports.dart';

Future<void> showChangePhoneSuccessSheet() {
  return showDefaultBottomSheet(
    child: const Directionality(
      textDirection: ui.TextDirection.rtl,
      child: _ChangePhoneSuccessSheetBody(),
    ),
  );
}

class _ChangePhoneSuccessSheetBody extends StatelessWidget {
  const _ChangePhoneSuccessSheetBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: IconWidget(
            icon: AppAssets.svg.baseSvg.correct.path,
            height: AppSize.sH60,
            width: AppSize.sW60,
            color: AppColors.forth,
          ),
        ),
        AppSize.sH16.szH,
        Text(
          LocaleKeys.changePhoneSuccessTitle,
          textAlign: TextAlign.center,
          style: const TextStyle().setMainTextColor.s16.semiBold.setFontFamily,
        ),
        AppSize.sH8.szH,
        Text(
          LocaleKeys.changePhoneSuccessSubtitle,
          textAlign: TextAlign.center,
          style: const TextStyle().setPrimaryColor.s14.regular.setFontFamily,
        ),
        AppSize.sH30.szH,
        DefaultButton(
          title: LocaleKeys.changePhoneBackToHome,
          onTap: () {
            Navigator.of(context).pop();
            Future.microtask(Go.backToInitial);
          },
        ),
        AppSize.sH12.szH,
      ],
    ).paddingSymmetric(horizontal: AppPadding.pW16);
  }
}
