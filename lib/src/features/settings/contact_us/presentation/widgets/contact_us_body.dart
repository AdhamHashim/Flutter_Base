part of '../imports/contact_us_imports.dart';

class _ContactUsBody extends StatefulWidget {
  const _ContactUsBody();

  @override
  State<_ContactUsBody> createState() => _ContactUsBodyState();
}

class _ContactUsBodyState extends State<_ContactUsBody> {
  late final ContactUsViewController _vc = ContactUsViewController();

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  Future<void> _onWhatsAppTap() async {
    try {
      await LauncherHelper.launchWhatsApp(ConstantManager.supportWhatsAppPhone);
    } catch (_) {
      if (!mounted) return;
      MessageUtils.showSnackBar(
        context: context,
        baseStatus: BaseStatus.error,
        message: LocaleKeys.checkInternet,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ContactUsCubit>();
    return Form(
      key: _vc.formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppMargin.mH20,
                children: [
                  if (!UserCubit.instance.isUserLoggedIn) ...[
                    CustomTextFiled(
                      borderRadius: BorderRadius.circular(AppCircular.r15),
                      controller: _vc.fullNameController,
                      hint: LocaleKeys.contactUsNameHint,
                      title: LocaleKeys.name,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      isOptional: false,
                      inputFormatters: [TextOnlyFormatter()],
                      validator: (value) => Validators.validateEmpty(
                        value,
                        fieldTitle: LocaleKeys.name,
                      ),
                    ),
                    CustomTextFiled(
                      borderRadius: BorderRadius.circular(AppCircular.r15),
                      controller: _vc.phoneController,
                      hint: LocaleKeys.contactUsPhoneHint,
                      title: LocaleKeys.phoneNumber,
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      isOptional: false,
                      inputFormatters: [
                        PhoneNumberFormatter(),
                        ArabicNumbersFormatter(),
                      ],
                      validator: (value) => Validators.validatePhone(
                        value,
                        fieldTitle: LocaleKeys.phoneNumber,
                      ),
                    ),
                  ],
                  CustomTextFiled(
                    borderRadius: BorderRadius.circular(AppCircular.r15),
                    controller: _vc.requestTypeController,
                    hint: LocaleKeys.contactUsRequestTypeHint,
                    title: LocaleKeys.contactUsRequestTypeLabel,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    isOptional: false,
                    inputFormatters: [TextWithNumberFormatter()],
                    validator: (value) => Validators.validateEmpty(
                      value,
                      fieldTitle: LocaleKeys.contactUsRequestTypeLabel,
                    ),
                  ),
                  CustomTextFiled(
                    borderRadius: BorderRadius.circular(AppCircular.r15),
                    controller: _vc.detailsController,
                    hint: LocaleKeys.contactUsDetailsHint,
                    title: LocaleKeys.contactUsDetailsLabel,
                    maxLines: ConstantManager.maxLines,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    isOptional: false,
                    inputFormatters: [TextWithNumberFormatter()],
                    validator: (value) => Validators.validateEmpty(
                      value,
                      fieldTitle: LocaleKeys.contactUsDetailsLabel,
                    ),
                  ),
                  _ContactUsAttachmentField(vc: _vc),
                  Center(
                    child: Text(
                      LocaleKeys.contactUsOr,
                      textAlign: TextAlign.center,
                      style: const TextStyle().setMainTextColor.s14.semiBold,
                    ),
                  ).paddingSymmetric(vertical: AppPadding.pH4),
                  LoadingButton.withWidget(
                    color: AppColors.success,
                    borderRadius: AppCircular.r15,
                    height: AppSize.sH60,
                    onTap: () async => _onWhatsAppTap(),
                    titleAsWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconWidget(
                          icon: AppAssets.svg.wzeinIcons.whatsapp.path,
                          height: AppSize.sH22,
                          width: AppSize.sW20,
                          color: AppColors.white,
                        ),
                        AppMargin.mW10.szW,
                        Text(
                          LocaleKeys.contactUsWhatsapp,
                          style: const TextStyle().setWhiteColor.s14.semiBold,
                        ),
                      ],
                    ),
                  ),
                  AppMargin.mH8.szH,
                ],
              ).paddingSymmetric(
                vertical: AppPadding.pH4,
                horizontal: AppPadding.pW14,
              ),
            ),
          ),
          LoadingButton(
            title: LocaleKeys.contactUsConfirm,
            color: AppColors.forth,
            borderRadius: AppCircular.r20,
            height: AppSize.sH55,
            onTap: () async => cubit.contactUs(_vc),
          ).paddingSymmetric(
            vertical: AppPadding.pH12,
            horizontal: AppPadding.pW14,
          ),
        ],
      ),
    );
  }
}
