part of '../imports/view_imports.dart';

class _ChangePhoneOtpBody extends StatelessWidget {
  const _ChangePhoneOtpBody({
    required this.vc,
    required this.subtitleText,
    required this.onConfirm,
    required this.onResend,
  });

  final ChangePhoneOtpViewController vc;
  final String subtitleText;
  final Future<void> Function() onConfirm;
  final Future<void> Function() onResend;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: AppAssets.svg.appSvg.logo.svg(
              width: 135.w,
            ),
          ),
          AppSize.sH18.szH,
          Text(
            LocaleKeys.registerVerifyCodeTitle,
            textAlign: TextAlign.center,
            style: const TextStyle().setMainTextColor.s18.semiBold.setFontFamily,
          ),
          AppSize.sH10.szH,
          Text(
            subtitleText,
            textAlign: TextAlign.center,
            style: const TextStyle().setPrimaryColor.s14.regular.setFontFamily,
          ),
          AppSize.sH20.szH,
          CustomPinTextField(
            controller: vc.otpController,
            length: 4,
            onCompleted: (_) {},
          ),
          AppSize.sH16.szH,
          ValueListenableBuilder<int>(
            valueListenable: vc.resendSeconds,
            builder: (context, seconds, child) {
              if (seconds > 0) {
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
              }
              return Center(
                child: Text(
                  LocaleKeys.changePhoneResendCode,
                  style: const TextStyle()
                      .setColor(AppColors.forth)
                      .s14
                      .semiBold
                      .setFontFamily,
                ).onClick(onTap: () => onResend()),
              );
            },
          ),
          AppSize.sH20.szH,
          Container(
            padding: EdgeInsets.all(AppPadding.pH12),
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
            onTap: onConfirm,
          ),
        ],
      ).paddingSymmetric(horizontal: AppPadding.pW14),
    );
  }
}
