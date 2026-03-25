part of '../imports/view_imports.dart';

class _RegisterVerifyOtpBody extends StatefulWidget {
  const _RegisterVerifyOtpBody();

  @override
  State<_RegisterVerifyOtpBody> createState() => _RegisterVerifyOtpBodyState();
}

class _RegisterVerifyOtpBodyState extends State<_RegisterVerifyOtpBody> {
  final TextEditingController _otpController = TextEditingController();
  final ValueNotifier<int> _resendSeconds = ValueNotifier(44);

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      if (_resendSeconds.value <= 0) return false;
      _resendSeconds.value--;
      return true;
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _resendSeconds.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegisterHeaderWidget(
              title: LocaleKeys.registerVerifyCodeTitle,
              subtitle: LocaleKeys.registerVerifyCodeSubtitle,
            ),
            AppSize.sH20.szH,
            CustomPinTextField(
              controller: _otpController,
              length: 6,
              onCompleted: (_) {},
            ),
            AppSize.sH16.szH,
            ValueListenableBuilder<int>(
              valueListenable: _resendSeconds,
              builder: (context, seconds, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.registerResendAfter,
                      style: const TextStyle()
                          .setPrimaryColor
                          .s14
                          .regular
                          .setFontFamily,
                    ),
                    4.szW,
                    Text(
                      '$seconds',
                      style: const TextStyle()
                          .setColor(AppColors.forth)
                          .s16
                          .medium
                          .setFontFamily,
                    ),
                    4.szW,
                    Text(
                      LocaleKeys.registerSeconds,
                      style: const TextStyle()
                          .setPrimaryColor
                          .s14
                          .regular
                          .setFontFamily,
                    ),
                  ],
                );
              },
            ),
            AppSize.sH20.szH,
            Container(
              padding: EdgeInsets.all(AppPadding.pH16),
              decoration: BoxDecoration(
                color: AppColors.infoBoxLight,
                borderRadius: BorderRadius.circular(AppCircular.r12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.registerDidntReceiveCode,
                          style: const TextStyle()
                              .setMainTextColor
                              .s14
                              .semiBold
                              .setFontFamily,
                        ),
                        AppSize.sH4.szH,
                        Text(
                          LocaleKeys.registerVerifyPhone,
                          style: const TextStyle()
                              .setHintColor
                              .s13
                              .regular
                              .setFontFamily,
                        ),
                      ],
                    ),
                  ),
                  IconWidget(
                    icon: AppAssets.svg.baseSvg.notify.path,
                    color: AppColors.forth,
                    height: AppSize.sH20,
                    width: AppSize.sW20,
                  ),
                ],
              ),
            ),
            AppSize.sH30.szH,
            LoadingButton(
              title: LocaleKeys.confirm,
              color: AppColors.forth,
              borderRadius: AppCircular.r20,
              onTap: () async {
                if (_otpController.text.length != 6) return;
                await Future.delayed(const Duration(milliseconds: 400));
                if (!context.mounted) return;
                Go.to(const RegisterCreatePinScreen());
              },
            ),
          ],
        ).paddingSymmetric(horizontal: AppPadding.pW14),
      ),
    );
  }
}
