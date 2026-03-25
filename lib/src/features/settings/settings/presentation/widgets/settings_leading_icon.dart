part of '../imports/view_imports.dart';

class _SettingsLeadingIcon extends StatelessWidget {
  const _SettingsLeadingIcon({required this.iconPath});

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.sH40,
      height: AppSize.sH40,
      decoration: const BoxDecoration(
        color: AppColors.selectedButton,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconWidget(
          icon: iconPath,
          width: AppSize.sW18,
          height: AppSize.sH18,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
