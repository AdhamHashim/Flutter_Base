part of '../imports/view_imports.dart';

class _ReportsExportSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.reportsExportTitle.tr(),
          style: const TextStyle().setMainTextColor.s14.semiBold,
        ),
        AppMargin.mH10.szH,
        Row(
          children: [
            Expanded(
              child: DefaultButton(
                width: double.infinity,
                height: AppSize.sH50,
                color: AppColors.cardFill,
                textColor: AppColors.main,
                borderColor: AppColors.border,
                borderRadius: BorderRadius.circular(AppCircular.r12),
                customChild: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconWidget(
                      icon: AppAssets.svg.wzeinIcons.file.path,
                      height: AppSize.sH20,
                      width: AppSize.sW20,
                      color: AppColors.error,
                    ),
                    AppMargin.mW8.szW,
                    Text(
                      LocaleKeys.reportsExportPdf.tr(),
                      style: const TextStyle().setMainTextColor.s12.medium,
                    ),
                  ],
                ),
                onTap: () => MessageUtils.showSnackBar(
                  context: context,
                  baseStatus: BaseStatus.success,
                  message: LocaleKeys.reportsExportStarted.tr(),
                ),
              ),
            ),
            AppMargin.mW10.szW,
            Expanded(
              child: DefaultButton(
                width: double.infinity,
                height: AppSize.sH50,
                color: AppColors.cardFill,
                textColor: AppColors.main,
                borderColor: AppColors.border,
                borderRadius: BorderRadius.circular(AppCircular.r12),
                customChild: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconWidget(
                      icon: AppAssets.svg.wzeinIcons.file.path,
                      height: AppSize.sH20,
                      width: AppSize.sW20,
                      color: AppColors.success,
                    ),
                    AppMargin.mW8.szW,
                    Text(
                      LocaleKeys.reportsExportExcel.tr(),
                      style: const TextStyle().setMainTextColor.s12.medium,
                    ),
                  ],
                ),
                onTap: () => MessageUtils.showSnackBar(
                  context: context,
                  baseStatus: BaseStatus.success,
                  message: LocaleKeys.reportsExportStarted.tr(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
