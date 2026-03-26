part of '../imports/view_imports.dart';

class _RegisterBody extends StatefulWidget {
  const _RegisterBody();

  @override
  State<_RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<_RegisterBody> {
  final RegisterParams params = RegisterParams();

  static const List<MapEntry<String, String>> _typeOptions = [
    MapEntry('male', 'malee'),
    MapEntry('female', 'femalee'),
  ];

  @override
  void dispose() {
    params.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Form(
        key: params.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegisterHeaderWidget(
              title: LocaleKeys.registerCreateAccountTitle,
              subtitle: LocaleKeys.registerCreateAccountSubtitle,
            ),
            AppSize.sH20.szH,
            CustomTextFiled(
              title: LocaleKeys.registerPhoneLabel,
              hint: LocaleKeys.registerPhoneHint,
              controller: params.phoneController,
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
              prefixIcon: Icon(
                Icons.phone_outlined,
                color: AppColors.forth,
                size: AppSize.sH18,
              ),
            ),
            AppSize.sH20.szH,
            CustomTextFiled(
              title: LocaleKeys.registerUsernameLabel,
              hint: LocaleKeys.registerUsernameHint,
              controller: params.usernameController,
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: (v) => Validators.validateEmpty(
                v,
                fieldTitle: LocaleKeys.registerUsernameLabel,
              ),
              inputFormatters: [TextWithNumberFormatter(allowArabic: true)],
              prefixIcon: IconWidget(
                icon: AppAssets.svg.wzeinIcons.div28.path,
                height: AppSize.sH16,
                width: AppSize.sW16,
              ).paddingAll(AppPadding.pW4),
            ),
            AppSize.sH20.szH,
            ValueListenableBuilder<String?>(
              valueListenable: params.selectedType,
              builder: (context, selected, child) {
                return AppDropdown<String>(
                  items: _typeOptions.map((e) => e.key).toList(),
                  label: LocaleKeys.registerTypeLabel,
                  hint: LocaleKeys.registerTypeHint,
                  value: selected,

                  itemAsString: (id) {
                    final entry = _typeOptions.firstWhere(
                      (e) => e.key == id,
                      orElse: () => const MapEntry('', ''),
                    );
                    return entry.value == 'malee'
                        ? LocaleKeys.malee
                        : LocaleKeys.femalee;
                  },
                  onChanged: (v) => params.selectedType.value = v,
                  validator: (v) => Validators.validateDropDown(
                    v,
                    fieldTitle: LocaleKeys.registerTypeLabel,
                  ),
                );
              },
            ),
            AppSize.sH20.szH,
            CustomTextFiled(
              title: LocaleKeys.registerNicknameLabel,
              hint: LocaleKeys.registerNicknameHint,
              controller: params.nicknameController,
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.next,
              isOptional: true,
              inputFormatters: [TextWithNumberFormatter(allowArabic: true)],
              validator: (v) => Validators.noValidate(v ?? ''),
              prefixIcon: IconWidget(
                icon: AppAssets.svg.wzeinIcons.div37.path,
                height: AppSize.sH16,
                width: AppSize.sW16,
              ).paddingAll(AppPadding.pW4),
            ),
            AppSize.sH8.szH,
            Text(
              LocaleKeys.registerNicknameHelper,
              style: const TextStyle().setHintColor.s12.regular.setFontFamily,
            ),
            AppSize.sH12.szH,
            CustomTextFiled(
              title: LocaleKeys.registerPasswordLabel,
              hint: '********',
              controller: params.passwordController,
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              isPassword: true,
              validator: (v) => Validators.validatePassword(
                v,
                fieldTitle: LocaleKeys.registerPasswordLabel,
              ),
              prefixIcon: IconWidget(
                icon: AppAssets.svg.wzeinIcons.circlePassword.path,
                // color: AppColors.forth,
                height: AppSize.sH16,
                width: AppSize.sW16,
              ).paddingAll(AppPadding.pW8),
            ),
            AppSize.sH20.szH,
            CustomTextFiled(
              title: LocaleKeys.registerConfirmPasswordLabel,
              hint: '********',
              controller: params.confirmPasswordController,
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              isPassword: true,
              validator: (v) => Validators.validatePasswordConfirm(
                v,
                params.passwordController.text,
                fieldTitle: LocaleKeys.registerConfirmPasswordLabel,
              ),
              prefixIcon: IconWidget(
                icon: AppAssets.svg.wzeinIcons.circlePassword.path,
                // color: AppColors.forth,
                height: AppSize.sH16,
                width: AppSize.sW16,
              ).paddingAll(AppPadding.pW8),
            ),
            AppSize.sH20.szH,
            LoadingButton(
              title: LocaleKeys.registerCreateAccountBtn,
              color: AppColors.forth,
              borderRadius: AppCircular.r20,
              onTap: () async {
                if (!params.validateAndScroll()) return;
                await Future.delayed(const Duration(milliseconds: 400));
                if (!context.mounted) return;
                Go.to(
                  RegisterVerifyOtpScreen(
                    phone: params.phoneController.text.toEnglishNumbers(),
                  ),
                );
              },
            ),
            AppSize.sH16.szH,
            DefaultButton(
              title: LocaleKeys.registerHaveAccountBtn,
              color: AppColors.scaffoldBackground,
              borderColor: AppColors.forth,
              textColor: AppColors.forth,
              borderRadius: BorderRadius.circular(AppCircular.r20),
              onTap: () => Go.back(),
            ),
          ],
        ).paddingSymmetric(horizontal: AppPadding.pW14),
      ),
    );
  }
}
