part of '../imports/profile_view_imports.dart';

void showProfileChangePasswordSheet(BuildContext context) {
  showDefaultBottomSheet(
    context: context,
    child: const Directionality(
      textDirection: ui.TextDirection.rtl,
      child: _ChangePasswordSheetBody(),
    ),
  );
}

class _ChangePasswordSheetBody extends StatefulWidget {
  const _ChangePasswordSheetBody();

  @override
  State<_ChangePasswordSheetBody> createState() =>
      _ChangePasswordSheetBodyState();
}

class _ChangePasswordSheetBodyState extends State<_ChangePasswordSheetBody>
    with FormMixin {
  late final ChangePasswordViewController _vc = ChangePasswordViewController();

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.changePassword,
            textAlign: TextAlign.center,
            style: const TextStyle().setMainTextColor.s14.semiBold,
          ).paddingSymmetric(horizontal: AppPadding.pW8),
          AppSize.sH20.szH,
          CustomTextFiled(
            title: LocaleKeys.currentPassword,
            hint: LocaleKeys.loginPasswordHint,
            controller: _vc.currentController,
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            isPassword: true,
            isOptional: false,
            validator: (v) => Validators.validatePassword(
              v,
              fieldTitle: LocaleKeys.currentPassword,
            ),
            borderRadius: BorderRadius.circular(AppCircular.r15),
            prefixIcon: Center(
              child: IconWidget(
                icon: AppAssets.svg.wzeinIcons.circlePassword.path,
                height: AppSize.sH16,
                width: AppSize.sW16,
              ),
            ).paddingAll(AppPadding.pW8),
          ),
          AppSize.sH16.szH,
          CustomTextFiled(
            title: LocaleKeys.newPassword,
            hint: LocaleKeys.loginPasswordHint,
            controller: _vc.newController,
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            isPassword: true,
            isOptional: false,
            validator: (v) => Validators.validatePassword(
              v,
              fieldTitle: LocaleKeys.newPassword,
            ),
            borderRadius: BorderRadius.circular(AppCircular.r15),
            prefixIcon: Center(
              child: IconWidget(
                icon: AppAssets.svg.wzeinIcons.circlePassword.path,
                height: AppSize.sH16,
                width: AppSize.sW16,
              ),
            ).paddingAll(AppPadding.pW8),
          ),
          AppSize.sH16.szH,
          CustomTextFiled(
            title: LocaleKeys.confirmPassword,
            hint: LocaleKeys.loginPasswordHint,
            controller: _vc.confirmController,
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            isPassword: true,
            isOptional: false,
            validator: (v) => Validators.validatePasswordConfirm(
              v,
              _vc.newController.text,
              fieldTitle: LocaleKeys.confirmPassword,
            ),
            borderRadius: BorderRadius.circular(AppCircular.r15),
            prefixIcon: Center(
              child: IconWidget(
                icon: AppAssets.svg.wzeinIcons.circlePassword.path,
                height: AppSize.sH16,
                width: AppSize.sW16,
              ),
            ).paddingAll(AppPadding.pW8),
          ),
          AppSize.sH25.szH,
          LoadingButton(
            title: LocaleKeys.confirm,
            color: AppColors.forth,
            borderRadius: AppCircular.r15,
            height: AppSize.sH60,
            onTap: () async {
              if (!validateAndScroll()) {
                return;
              }
              await Future<void>.delayed(const Duration(milliseconds: 400));
              if (!context.mounted) {
                return;
              }
              Navigator.of(context).pop();
              await successDialog(
                context: Go.context,
                title: LocaleKeys.dataUpdatedSuccessfully,
              );
            },
          ),
          AppSize.sH16.szH,
        ],
      ).paddingSymmetric(horizontal: AppPadding.pW10),
    );
  }
}
