part of '../imports/view_imports.dart';

class _LoginBody extends StatefulWidget {
  const _LoginBody();

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  late final LoginViewController _vc = LoginViewController();

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Form(
        key: _vc.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegisterHeaderWidget(
              title: LocaleKeys.loginScreenTitle,
              subtitle: LocaleKeys.registerCreateAccountSubtitle,
            ),
            AppSize.sH20.szH,
            CustomTextFiled(
              title: LocaleKeys.registerPhoneLabel,
              hint: LocaleKeys.registerPhoneHint,
              controller: _vc.phoneController,
              textInputType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              validator: (v) => Validators.validatePhone(
                v,
                fieldTitle: LocaleKeys.registerPhoneLabel,
              ),
              inputFormatters: [
                PhoneNumberFormatter(),
                ArabicNumbersFormatter(),
              ],
              fillColor: AppColors.white,
              borderRadius: BorderRadius.circular(AppCircular.r15),
              prefixIcon: Icon(
                Icons.phone_outlined,
                color: AppColors.forth,
                size: AppSize.sH18,
              ),
            ),
            AppSize.sH20.szH,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.mH6,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: AppMargin.mW2,
                  children: [
                    Text(
                      '*',
                      style: const TextStyle()
                          .setColor(AppColors.error)
                          .s13
                          .regular,
                    ),
                    Text(
                      LocaleKeys.registerPasswordLabel,
                      style: const TextStyle().setMainTextColor.s13.regular,
                    ),
                  ],
                ),
                DefaultTextField(
                  controller: _vc.passwordController,
                  isPassword: true,
                  inputType: TextInputType.visiblePassword,
                  action: TextInputAction.done,
                  validator: (v) => Validators.validatePassword(
                    v,
                    fieldTitle: LocaleKeys.registerPasswordLabel,
                  ),
                  title: LocaleKeys.loginPasswordHint,
                  fillColor: AppColors.white,
                  borderRadius: BorderRadius.circular(AppCircular.r15),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppPadding.pW8,
                    vertical: AppPadding.pH14,
                  ),
                  style: const TextStyle().setMainTextColor.s12.regular,
                  prefixIcon: IconWidget(
                    icon: AppAssets.svg.wzeinIcons.circlePassword.path,
                    height: AppSize.sH16,
                    width: AppSize.sW16,
                  ).paddingAll(AppPadding.pW8),
                ),
              ],
            ),
            AppSize.sH20.szH,
            LoadingButton(
              title: LocaleKeys.confirm,
              color: AppColors.forth,
              borderRadius: AppCircular.r20,
              height: AppSize.sH55,
              onTap: () async {
                Go.offAll(const HomeScreen());
                return;
                if (!_vc.validateAndScroll()) return;
                await Future<void>.delayed(const Duration(milliseconds: 400));
                if (!context.mounted) return;
                Go.to(const LoginConfirmPinScreen());
              },
            ),
            AppSize.sH16.szH,
            DefaultButton(
              title: LocaleKeys.loginNoAccountRegister,
              color: AppColors.scaffoldBackground,
              borderColor: AppColors.forth,
              textColor: AppColors.forth,
              borderRadius: BorderRadius.circular(AppCircular.r20),
              height: AppSize.sH55,
              onTap: () => Go.to(const RegisterScreen()),
            ),
            AppSize.sH20.szH,
            const Center(child: _LoginForgotPasswordFooter()),
          ],
        ).paddingSymmetric(horizontal: AppPadding.pW14),
      ),
    );
  }
}
