part of '../imports/view_imports.dart';

class RegisterAutoLockInfoWidget extends StatelessWidget {
  const RegisterAutoLockInfoWidget({
    super.key,
    required this.title,
    required this.description,
    this.iconPath,
  });
  final String title;
  final String description;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.infoBoxLight,
            AppColors.infoBoxLight.withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(AppCircular.r15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle()
                      .setMainTextColor
                      .s14
                      .semiBold
                      .setFontFamily,
                ),
                AppSize.sH4.szH,
                Text(
                  description,
                  style: const TextStyle()
                      .setHintColor
                      .s13
                      .regular
                      .setFontFamily,
                ),
              ],
            ),
          ),
          IconWidget(
            icon: iconPath ?? AppAssets.svg.baseSvg.changePass.path,
            color: AppColors.forth,
            height: AppSize.sH20,
            width: AppSize.sW20,
          ),
        ],
      ),
    );
  }
}
