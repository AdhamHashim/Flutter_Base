part of '../imports/view_imports.dart';

class _SubscriptionsPaymentSheet {
  static Future<void> show(BuildContext context) async {
    await showDefaultBottomSheet(
      context: context,
      child: const Directionality(
        textDirection: ui.TextDirection.rtl,
        child: _SubscriptionsPaymentSheetBody(),
      ),
    );
  }
}

class _SubscriptionsPaymentSheetBody extends StatefulWidget {
  const _SubscriptionsPaymentSheetBody();

  @override
  State<_SubscriptionsPaymentSheetBody> createState() =>
      _SubscriptionsPaymentSheetBodyState();
}

class _SubscriptionsPaymentSheetBodyState
    extends State<_SubscriptionsPaymentSheetBody> {
  bool _electronicSelected = true;

  Future<void> _onConfirm() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (!mounted) return;
    Go.back();
    await Future<void>.delayed(Duration.zero);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!Go.context.mounted) return;
      showDefaultBottomSheet(
        context: Go.context,
        child: const Directionality(
          textDirection: ui.TextDirection.rtl,
          child: _SubscriptionsSuccessSheetBody(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: AppPadding.pW16,
        end: AppPadding.pW16,
        bottom: AppPadding.pH20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: IconWidget(
              icon: AppAssets.svg.baseSvg.changePass.path,
              height: AppSize.sH50,
              width: AppSize.sW50,
              color: AppColors.forth,
            ),
          ),
          AppMargin.mH20.szH,
          Text(
            LocaleKeys.subscriptionsPaymentMethodTitle,
            textAlign: TextAlign.center,
            style: const TextStyle().setMainTextColor.s16.regular,
          ),
          AppMargin.mH20.szH,
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.border),
            ),
            child: Material(
              color: AppColors.white,
              child: InkWell(
                onTap: () => setState(() => _electronicSelected = true),
                child: Row(
                  children: [
                    IconWidget(
                      icon: AppAssets.svg.wzeinIcons.button402.path,
                      height: AppSize.sH25,
                      width: AppSize.sW25,
                      color: AppColors.forth,
                    ),
                    AppMargin.mW16.szW,
                    Expanded(
                      child: Text(
                        LocaleKeys.subscriptionsPaymentElectronic,
                        textAlign: TextAlign.start,
                        style: const TextStyle().setHintColor.s14.regular,
                      ),
                    ),
                    _RadioDot(selected: _electronicSelected),
                  ],
                ).paddingSymmetric(
                  horizontal: AppPadding.pW16,
                  vertical: AppPadding.pH16,
                ),
              ),
            ),
          ),
          AppMargin.mH20.szH,
          LoadingButton(
            title: LocaleKeys.subscriptionsConfirm,
            height: AppSize.sH60,
            borderRadius: AppCircular.r15,
            color: AppColors.forth,
            onTap: _onConfirm,
          ),
        ],
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.sH25,
      height: AppSize.sH25,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.grey2, width: 1.5),
          color: AppColors.white,
        ),
        child: selected
            ? Center(
                child: Container(
                  width: AppSize.sH12,
                  height: AppSize.sH12,
                  decoration: const BoxDecoration(
                    color: AppColors.forth,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
