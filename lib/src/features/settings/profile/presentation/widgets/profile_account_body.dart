part of '../imports/profile_view_imports.dart';

class _ProfileAccountBody extends StatefulWidget {
  const _ProfileAccountBody({required this.profile});

  final ProfileEntity profile;

  @override
  State<_ProfileAccountBody> createState() => _ProfileAccountBodyState();
}

class _ProfileAccountBodyState extends State<_ProfileAccountBody> {
  static const List<MapEntry<String, String>> _genderOptions = [
    MapEntry('male', 'malee'),
    MapEntry('female', 'femalee'),
  ];

  late final TextEditingController _phoneController;
  late final TextEditingController _usernameController;
  late final TextEditingController _genderController;
  late final TextEditingController _nicknameController;

  String _genderLabel(String key) {
    final entry = _genderOptions.firstWhere(
      (e) => e.key == key,
      orElse: () => const MapEntry('male', 'malee'),
    );
    return entry.value == 'malee' ? LocaleKeys.malee : LocaleKeys.femalee;
  }

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _phoneController = TextEditingController(text: p.phone);
    _usernameController = TextEditingController(text: p.username);
    _genderController = TextEditingController(text: _genderLabel(p.genderKey));
    _nicknameController = TextEditingController(text: p.nickname);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _usernameController.dispose();
    _genderController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSize.sH12.szH,
          CustomTextFiled(
            title: LocaleKeys.registerPhoneLabel,
            hint: LocaleKeys.registerPhoneHint,
            controller: _phoneController,
            textInputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            readOnly: true,
            validator: (String? v) => Validators.noValidate(v ?? ''),
            borderRadius: BorderRadius.circular(AppCircular.r15),
            prefixIcon: Center(
              child: IconWidget(
                icon: AppAssets.svg.wzeinIcons.div2842.path,
                color: AppColors.forth,
                height: AppSize.sH18,
                width: AppSize.sW18,
              ),
            ),
          ),
          AppSize.sH20.szH,
          CustomTextFiled(
            title: LocaleKeys.registerUsernameLabel,
            hint: LocaleKeys.registerUsernameHint,
            controller: _usernameController,
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            readOnly: true,
            validator: (String? v) => Validators.noValidate(v ?? ''),
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
          CustomTextFiled(
            title: LocaleKeys.registerTypeLabel,
            hint: LocaleKeys.registerTypeHint,
            controller: _genderController,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            readOnly: true,
            validator: (String? v) => Validators.noValidate(v ?? ''),
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
          CustomTextFiled(
            title: LocaleKeys.registerNicknameLabel,
            hint: LocaleKeys.registerNicknameHint,
            controller: _nicknameController,
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.done,
            readOnly: true,
            isOptional: true,
            validator: (String? v) => Validators.noValidate(v ?? ''),
            borderRadius: BorderRadius.circular(AppCircular.r15),
            prefixIcon: Center(
              child: IconWidget(
                icon: AppAssets.svg.wzeinIcons.div37.path,
                height: AppSize.sH18,
                width: AppSize.sW18,
              ),
            ),
          ),
          AppSize.sH25.szH,
        ],
      ).paddingSymmetric(horizontal: AppPadding.pW14),
    );
  }
}
