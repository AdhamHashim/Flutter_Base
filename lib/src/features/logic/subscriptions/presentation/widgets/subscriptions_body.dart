part of '../imports/view_imports.dart';

class _SubscriptionsBody extends StatefulWidget {
  const _SubscriptionsBody();

  @override
  State<_SubscriptionsBody> createState() => _SubscriptionsBodyState();
}

class _SubscriptionsBodyState extends State<_SubscriptionsBody> {
  late final SubscriptionsViewController _vc;

  @override
  void initState() {
    super.initState();
    _vc = SubscriptionsViewController();
  }

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  Future<void> _openPaymentSheet() async {
    await _SubscriptionsPaymentSheet.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsetsDirectional.only(
              start: AppPadding.pW16,
              end: AppPadding.pW16,
              bottom: AppPadding.pH20,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _SubscriptionsTrialBanner(),
                  AppMargin.mH20.szH,
                  _SubscriptionsPlanCard(vc: _vc),
                  AppMargin.mH20.szH,
                  LoadingButton(
                    title: LocaleKeys.subscriptionsPaySubscribe,
                    height: AppSize.sH60,
                    borderRadius: AppCircular.r15,
                    color: AppColors.forth,
                    onTap: () async {
                      await _openPaymentSheet();
                    },
                  ),
                  AppMargin.mH20.szH,
                  const _SubscriptionsImportantNote(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
