part of '../imports/view_imports.dart';

class _LoginForgotPasswordFooter extends StatelessWidget {
  const _LoginForgotPasswordFooter();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.loginForgotPasswordQuestion,
          style: const TextStyle().setPrimaryColor.s14.medium.setFontFamily,
        ),
        Material(
          color: AppColors.white.withValues(alpha: 0),
            child: InkWell(
            onTap: () => Go.to(const ContactUsScreen()),
            borderRadius: BorderRadius.circular(AppCircular.r8),
            child: Text(
              LocaleKeys.loginContactAdministration,
              style: const TextStyle().setColor(AppColors.forth).s14.medium.setFontFamily,
            ).paddingSymmetric(
              horizontal: AppPadding.pW4,
              vertical: AppPadding.pH4,
            ),
          ),
        ),
      ],
    );
  }
}
