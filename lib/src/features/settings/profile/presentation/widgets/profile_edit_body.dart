part of '../imports/profile_view_imports.dart';

class _ProfileEditBody extends StatelessWidget {
  const _ProfileEditBody({
    required this.formKey,
    required this.vc,
  });

  final GlobalKey<FormState> formKey;
  final ProfileEditViewController vc;

  static const List<MapEntry<String, String>> _typeOptions = [
    MapEntry('male', 'malee'),
    MapEntry('female', 'femalee'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.sH12.szH,
            CustomTextFiled(
              title: LocaleKeys.registerUsernameLabel,
              hint: LocaleKeys.registerUsernameHint,
              controller: vc.usernameController,
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: (v) => Validators.validateEmpty(
                v,
                fieldTitle: LocaleKeys.registerUsernameLabel,
              ),
              inputFormatters: [TextWithNumberFormatter(allowArabic: true)],
              borderRadius: BorderRadius.circular(AppCircular.r15),
              prefixIcon: Center(
                child: IconWidget(
                  icon: AppAssets.svg.wzeinIcons.div28.path,
                  height: AppSize.sH18,
                  width: AppSize.sW18,
                ),
              ),
            ),
            AppSize.sH20.szH,
            ValueListenableBuilder<String?>(
              valueListenable: vc.selectedGender,
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
                  onChanged: (v) => vc.selectedGender.value = v,
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
              controller: vc.nicknameController,
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.done,
              isOptional: true,
              inputFormatters: [TextWithNumberFormatter(allowArabic: true)],
              validator: (v) => Validators.noValidate(v ?? ''),
              borderRadius: BorderRadius.circular(AppCircular.r15),
              prefixIcon: Center(
                child: IconWidget(
                  icon: AppAssets.svg.wzeinIcons.div37.path,
                  height: AppSize.sH18,
                  width: AppSize.sW18,
                ),
              ),
            ),
            AppSize.sH30.szH,
            Align(
              alignment: AlignmentDirectional.center,
              child: Text(
                LocaleKeys.changePassword,
                style: const TextStyle().setMainTextColor.s14.semiBold,
              ).onClick(
                onTap: () => showProfileChangePasswordSheet(context),
              ),
            ),
            AppSize.sH16.szH,
            LoadingButton(
              title: LocaleKeys.profileSaveChanges,
              color: AppColors.forth,
              borderRadius: AppCircular.r15,
              height: AppSize.sH60,
              onTap: () async {
                if (!formKey.validateAndScroll()) {
                  return;
                }
                await Future<void>.delayed(const Duration(milliseconds: 400));
                if (!context.mounted) return;
                await successDialog(
                  context: context,
                  title: LocaleKeys.dataUpdatedSuccessfully,
                );
              },
            ),
            AppSize.sH25.szH,
          ],
        ).paddingSymmetric(horizontal: AppPadding.pW14),
      ),
    );
  }
}
