part of '../imports/view_imports.dart';

class SettingsChevronRowWidget extends StatelessWidget {
  const SettingsChevronRowWidget({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  final String title;
  final String iconPath;
  final VoidCallback onTap;

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
        Transform(
          alignment: Alignment.center,
          transform: context.isRight
              ? Matrix4.rotationY(math.pi)
              : Matrix4.rotationX(math.pi),
          child: AppAssets.svg.baseSvg.arrowBack.svg(
            width: AppSize.sH16,
            height: AppSize.sH16,
          ),
        ),
      ],
    )
        .paddingSymmetric(vertical: AppPadding.pH12)
        .onClick(onTap: onTap);
  }
}
