part of '../imports/view_imports.dart';

class _SubscriptionsImportantNote extends StatelessWidget {
  const _SubscriptionsImportantNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.dashboardBackground,
        borderRadius: BorderRadius.circular(AppCircular.r15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSize.sW30,
            child: Center(
              child: IconWidget(
                icon: AppAssets.svg.baseSvg.notify.path,
                height: AppSize.sH20,
                width: AppSize.sW20,
                color: AppColors.forth,
              ),
            ),
          ),
          AppMargin.mW12.szW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.subscriptionsImportantNoteTitle,
                  style: const TextStyle().setSecondryColor.s14.semiBold,
                ),
                AppMargin.mH4.szH,
                Text(
                  LocaleKeys.subscriptionsImportantNoteBody,
                  style: const TextStyle().setPrimaryColor.s12.regular,
                ),
              ],
            ),
          ),
        ],
      ).paddingAll(AppPadding.pH16),
    );
  }
}
