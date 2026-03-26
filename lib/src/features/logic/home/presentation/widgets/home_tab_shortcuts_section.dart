part of '../imports/view_imports.dart';

class _HomeTabShortcutsSection extends StatelessWidget {
  const _HomeTabShortcutsSection();

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
              child: _HomeShortcutTile(
                iconPath: AppAssets.svg.wzeinIcons.aX338Expenses.path,
                label: LocaleKeys.homeTabShortcutExpense,
                iconColor: AppColors.forth,
              ),
            ),
            AppMargin.mW12.szW,
            Expanded(
              child: _HomeShortcutTile(
                iconPath: AppAssets.svg.wzeinIcons.button19.path,
                label: LocaleKeys.homeTabShortcutWarranty,
                iconColor: AppColors.info,
              ),
            ),
            AppMargin.mW12.szW,
            Expanded(
              child: _HomeShortcutTile(
                iconPath: AppAssets.svg.wzeinIcons.add01.path,
                label: LocaleKeys.homeTabShortcutFuturePurchases,
                iconColor: AppColors.forth,
                maxLabelLines: 2,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: AppPadding.pW20),
      ],
    );
  }
}

class _HomeShortcutTile extends StatelessWidget {
  const _HomeShortcutTile({
    required this.iconPath,
    required this.label,
    required this.iconColor,
    this.maxLabelLines = 1,
  });

  final String iconPath;
  final String label;
  final Color iconColor;
  final int maxLabelLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: AppSize.sH60,
          height: AppSize.sH60,
          decoration: BoxDecoration(
            color: AppColors.cardFill,
            borderRadius: BorderRadius.circular(AppCircular.r10),
            boxShadow: [AppColors.containerShadow],
          ),
          child: Center(
            child: IconWidget(
              icon: iconPath,
              width: AppSize.sW25,
              height: AppSize.sH25,
              color: iconColor,
            ),
          ),
        ).onClick(onTap: () {}),
        AppMargin.mH8.szH,
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: maxLabelLines,
          overflow: TextOverflow.ellipsis,
          style:
              const TextStyle().setSecondryColor.s14.medium.setFontFamily,
        ),
      ],
    );
  }
}
