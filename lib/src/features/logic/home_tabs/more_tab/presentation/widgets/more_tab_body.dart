part of '../imports/view_imports.dart';

class _MoreTabBody extends StatelessWidget {
  const _MoreTabBody();

  @override
  Widget build(BuildContext context) {
    context.locale;
    final isLoggedIn = UserCubit.instance.isUserLoggedIn;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _MoreTabHeaderWidget(),
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppMargin.mH20,
              children: [
                if (isLoggedIn) const _MoreSubscriptionCardWidget(),
                if (isLoggedIn)
                  _MoreSectionWidget(
                    titleKey: LocaleKeys.moreAccountSection,
                    items: MoreItemEntity.accountItems,
                  ),
                if (isLoggedIn)
                  _MoreSectionWidget(
                    titleKey: LocaleKeys.moreAppSection,
                    items: MoreItemEntity.appItems,
                  ),
                _MoreSectionWidget(
                  titleKey: LocaleKeys.moreSupportSection,
                  items: isLoggedIn
                      ? MoreItemEntity.supportItems
                      : MoreItemEntity.guestSupportItems,
                ),
                if (isLoggedIn) const _MoreLogoutSectionWidget(),
                AppMargin.mH16.szH,
              ],
            ).paddingSymmetric(horizontal: AppPadding.pW14),
          ),
        ),
      ],
    );
  }
}
