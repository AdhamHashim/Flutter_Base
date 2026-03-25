part of '../imports/view_imports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return DefaultScaffold(
      showArrow: false,
      title: LocaleKeys.settingsGeneralTitle,
      headLineWidget: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: AppSize.sH40,
            height: AppSize.sH40,
            decoration: const BoxDecoration(
              color: AppColors.selectedButton,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: ArrowWidget(
                width: AppSize.sW20,
                height: AppSize.sH20,
              ),
            ),
          ),
          AppMargin.mW8.szW,
          Expanded(
            child: Text(
              LocaleKeys.settingsGeneralTitle,
              textAlign: TextAlign.start,
              style: const TextStyle().setMainTextColor.s18.semiBold,
            ),
          ),
          AppSize.sW40.szW,
        ],
      ),
      body: const _SettingsTabBody(),
    );
  }
}
