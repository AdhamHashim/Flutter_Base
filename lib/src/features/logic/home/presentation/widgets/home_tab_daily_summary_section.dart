part of '../imports/view_imports.dart';

class _HomeTabDailySummarySection extends StatelessWidget {
  const _HomeTabDailySummarySection({required this.model});

  final HomeTabUiModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppMargin.mH20.szH,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _HomeDailyStatCard(
                iconPath: AppAssets.svg.wzeinIcons.button40.path,
                iconBackground: AppColors.grey1,
                iconColor: AppColors.info,
                title: LocaleKeys.homeTabTodayExpense,
                amount: model.todayExpenseAmount,
              ),
            ),
            AppMargin.mW12.szW,
            Expanded(
              child: _HomeDailyStatCard(
                iconPath: AppAssets.svg.wzeinIcons.button48.path,
                iconBackground: AppColors.grey1,
                iconColor: AppColors.forth,
                title: LocaleKeys.homeTabPurchases,
                amount: model.purchasesAmount,
              ),
            ),
            AppMargin.mW12.szW,
            Expanded(
              child: _HomeDailyStatCard(
                iconPath: AppAssets.svg.wzeinIcons.button6.path,
                iconBackground: AppColors.border,
                iconColor: AppColors.success,
                title: LocaleKeys.homeTabBillsObligations,
                amount: model.billsAmount,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: AppPadding.pW20),
      ],
    );
  }
}

class _HomeDailyStatCard extends StatelessWidget {
  const _HomeDailyStatCard({
    required this.iconPath,
    required this.iconBackground,
    required this.iconColor,
    required this.title,
    required this.amount,
  });

  final String iconPath;
  final Color iconBackground;
  final Color iconColor;
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(AppCircular.r15),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppSize.sH40,
            height: AppSize.sH40,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconWidget(
                icon: iconPath,
                width: AppSize.sW18,
                height: AppSize.sH18,
                color: iconColor,
              ),
            ),
          ),
          AppMargin.mH12.szH,
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style:
                const TextStyle().setPrimaryColor.s12.regular.setFontFamily,
          ),
          AppMargin.mH4.szH,
          Text(
            amount,
            style:
                const TextStyle().setMainTextColor.s18.semiBold.setFontFamily,
          ),
          Text(
            LocaleKeys.homeTabCurrencyRiyal,
            style: const TextStyle().setHintColor.s13.regular.setFontFamily,
          ),
        ],
      ),
    ).onClick(onTap: () {});
  }
}
