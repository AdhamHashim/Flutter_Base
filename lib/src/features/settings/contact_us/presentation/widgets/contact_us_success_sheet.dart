part of '../imports/contact_us_imports.dart';

void showContactUsSuccessBottomSheet() {
  showDefaultBottomSheet(
    child: const Directionality(
      textDirection: TextDirection.rtl,
      child: _ContactUsSuccessSheetBody(),
    ),
  );
}

class _ContactUsSuccessSheetBody extends StatefulWidget {
  const _ContactUsSuccessSheetBody();

  @override
  State<_ContactUsSuccessSheetBody> createState() =>
      _ContactUsSuccessSheetBodyState();
}

class _ContactUsSuccessSheetBodyState extends State<_ContactUsSuccessSheetBody> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.of(context).maybePop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: AppPadding.pW20,
        end: AppPadding.pW20,
        bottom: AppPadding.pH20,
        top: AppPadding.pH8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppAssets.lottie.successfullOrder.lottie(
            height: AppSize.sH60,
            width: AppSize.sH60,
            fit: BoxFit.contain,
          ),
          AppMargin.mH16.szH,
          Text(
            LocaleKeys.contactUsSuccessAdmin,
            textAlign: TextAlign.center,
            style: const TextStyle().setMainTextColor.s16.medium,
          ),
        ],
      ),
    );
  }
}
