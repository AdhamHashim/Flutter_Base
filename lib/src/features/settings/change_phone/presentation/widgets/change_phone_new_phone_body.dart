part of '../imports/view_imports.dart';

class _ChangePhoneNewPhoneBody extends StatefulWidget {
  const _ChangePhoneNewPhoneBody();

  @override
  State<_ChangePhoneNewPhoneBody> createState() =>
      _ChangePhoneNewPhoneBodyState();
}

class _ChangePhoneNewPhoneBodyState extends State<_ChangePhoneNewPhoneBody> {
  late final ChangePhoneNewPhoneViewController _vc = ChangePhoneNewPhoneViewController();
  ChangePhoneSmsBody? _submittedSmsBody;

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePhoneSendSmsToNewCubit, AsyncState<BaseModel?>>(
      listenWhen: (p, c) => c.isSuccess && !p.isSuccess,
      listener: (context, state) {
        final body = _submittedSmsBody;
        if (body == null) return;
        Go.to(ChangePhoneVerifyNewPhoneScreen(smsBody: body));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          key: _vc.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.changePhoneNewScreenSubtitle,
                style: const TextStyle().setPrimaryColor.s14.regular.setFontFamily,
              ),
              AppSize.sH20.szH,
              CustomTextFiled(
                title: LocaleKeys.changePhoneCountryCodeLabel,
                hint: LocaleKeys.changePhoneCountryCodeHint,
                controller: _vc.countryCodeController,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (v) {
                  final t = (v ?? '').toEnglishNumbers().trim();
                  if (t.isEmpty) {
                    return Validators.validateEmpty(
                      v,
                      fieldTitle: LocaleKeys.changePhoneCountryCodeLabel,
                    );
                  }
                  if (t.length < 2 || t.length > 4) {
                    return LocaleKeys.badRequest;
                  }
                  return null;
                },
                inputFormatters: [
                  IntegerNumberFormatter(),
                  ArabicNumbersFormatter(),
                ],
                prefixIcon: IconWidget(
                  icon: AppAssets.svg.baseSvg.notify.path,
                  height: AppSize.sH16,
                  width: AppSize.sW16,
                  color: AppColors.forth,
                ).paddingAll(AppPadding.pW4),
              ),
              AppSize.sH16.szH,
              CustomTextFiled(
                title: LocaleKeys.registerPhoneLabel,
                hint: LocaleKeys.registerPhoneHint,
                controller: _vc.phoneController,
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                validator: (v) => Validators.validatePhone(
                  v,
                  fieldTitle: LocaleKeys.registerPhoneLabel,
                ),
                inputFormatters: [
                  PhoneNumberFormatter(),
                  ArabicNumbersFormatter(),
                ],
                prefixIcon: IconWidget(
                  icon: AppAssets.svg.baseSvg.notify.path,
                  height: AppSize.sH16,
                  width: AppSize.sW16,
                  color: AppColors.forth,
                ).paddingAll(AppPadding.pW4),
              ),
              AppSize.sH30.szH,
              LoadingButton(
                title: LocaleKeys.confirm,
                color: AppColors.forth,
                borderRadius: AppCircular.r20,
                onTap: () async {
                  if (!_vc.validateAndScroll()) return;
                  final body = _vc.toSmsBody();
                  _submittedSmsBody = body;
                  await context
                      .read<ChangePhoneSendSmsToNewCubit>()
                      .sendSmsToNewPhone(body);
                },
              ),
            ],
          ).paddingAll(AppPadding.pH16),
        ),
      ),
    );
  }
}
