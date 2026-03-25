part of '../imports/view_imports.dart';

class RegisterHeaderWidget extends StatelessWidget {
  const RegisterHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: AppAssets.svg.appSvg.logo.svg(
            width: 135.w,
            // height: context.height * .16,
            // color: AppColors.forth,
          ),
        ),
        AppSize.sH18.szH,
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle().setMainTextColor.s18.semiBold.setFontFamily,
        ),
        AppSize.sH10.szH,
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle().setPrimaryColor.s14.regular.setFontFamily,
        ),
      ],
    );
  }
}
