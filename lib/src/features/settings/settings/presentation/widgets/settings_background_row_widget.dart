part of '../imports/view_imports.dart';

class SettingsBackgroundRowWidget extends StatelessWidget {
  const SettingsBackgroundRowWidget({
    super.key,
    required this.title,
    required this.iconPath,
    required this.viewController,
  });

  final String title;
  final String iconPath;
  final SettingsScreenViewController viewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _SettingsLeadingIcon(iconPath: iconPath),
        AppMargin.mW12.szW,
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle().setSecondryColor.s14.medium,
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: viewController.darkBackground,
          builder: (context, value, _) {
            return Switch(
              value: value,
              onChanged: (v) => viewController.onBackgroundToggle(v),
              activeTrackColor: AppColors.success,
              activeColor: AppColors.white,
            );
          },
        ),
      ],
    ).paddingSymmetric(vertical: AppPadding.pH12);
  }
}
