part of '../imports/view_imports.dart';

class _MoreSectionWidget extends StatelessWidget {
  const _MoreSectionWidget({required this.titleKey, required this.items});

  final String titleKey;
  final List<MoreItemEntity> items;

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(AppCircular.r15),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleKey,
            textAlign: TextAlign.start,
            textDirection: context.isArabic
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
            style:
                const TextStyle().setMainTextColor.s14.semiBold.setFontFamily,
          ),
          AppMargin.mH16.szH,
          ...items.map((item) => MoreMenuCardWidget(menuItem: item)),
        ],
      ).paddingAll(AppPadding.pH20),
    );
  }
}
