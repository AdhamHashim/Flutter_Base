part of '../imports/view_imports.dart';

class _SubscriptionsSuccessSheetBody extends StatefulWidget {
  const _SubscriptionsSuccessSheetBody();

  @override
  State<_SubscriptionsSuccessSheetBody> createState() =>
      _SubscriptionsSuccessSheetBodyState();
}

class _SubscriptionsSuccessSheetBodyState
    extends State<_SubscriptionsSuccessSheetBody> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Go.back();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppPadding.pH20,
        bottom: AppPadding.pH35,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconWidget(
            icon: AppAssets.svg.baseSvg.correct.path,
            height: AppSize.sH60,
            width: AppSize.sW60,
            color: AppColors.forth,
          ),
          AppMargin.mH16.szH,
          Text(
            LocaleKeys.subscriptionsPurchaseSuccess,
            textAlign: TextAlign.center,
            style: const TextStyle().setMainTextColor.s16.medium,
          ),
        ],
      ),
    );
  }
}
