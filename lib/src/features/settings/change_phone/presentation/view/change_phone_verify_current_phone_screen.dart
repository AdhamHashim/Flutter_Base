part of '../imports/view_imports.dart';

class ChangePhoneVerifyCurrentPhoneScreen extends StatelessWidget {
  const ChangePhoneVerifyCurrentPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injector<ChangePhoneVerifyCurrentPhoneCubit>(),
        ),
        BlocProvider(
          create: (_) => injector<ChangePhoneSendSmsToCurrentCubit>(),
        ),
      ],
      child: const _ChangePhoneVerifyCurrentView(),
    );
  }
}

class _ChangePhoneVerifyCurrentView extends StatefulWidget {
  const _ChangePhoneVerifyCurrentView();

  @override
  State<_ChangePhoneVerifyCurrentView> createState() =>
      _ChangePhoneVerifyCurrentViewState();
}

class _ChangePhoneVerifyCurrentViewState
    extends State<_ChangePhoneVerifyCurrentView> {
  late final ChangePhoneOtpViewController _vc = ChangePhoneOtpViewController();

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Helpers.changeStatusbarColor(
      statusBarColor: AppColors.scaffoldBackground,
      statusBarIconBrightness: Brightness.dark,
    );
  }

  Future<void> _onResend() async {
    final cubit = context.read<ChangePhoneSendSmsToCurrentCubit>();
    await cubit.sendSmsToCurrentPhone();
    if (!mounted) return;
    if (cubit.state.isSuccess) {
      _vc.startResendTimer();
      final msg = cubit.state.data?.message;
      if (msg != null && msg.isNotEmpty) {
        MessageUtils.showSnackBar(
          baseStatus: BaseStatus.success,
          message: msg,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final masked = changePhoneMaskedDisplay(
      UserCubit.instance.user.phoneNumber,
    );
    return BlocListener<ChangePhoneVerifyCurrentPhoneCubit,
        AsyncState<BaseModel?>>(
      listenWhen: (p, c) => c.isSuccess && !p.isSuccess,
      listener: (context, state) {
        Go.to(const ChangePhoneNewPhoneScreen());
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child: _ChangePhoneOtpBody(
            vc: _vc,
            subtitleText: LocaleKeys.changePhoneOtpSubtitleMasked(masked: masked),
            onConfirm: () async {
              final code = _vc.otpController.text.toEnglishNumbers();
              if (code.length != 4) {
                MessageUtils.showSnackBar(
                  baseStatus: BaseStatus.error,
                  message: LocaleKeys.emptyOtpRequired,
                );
                return;
              }
              await context
                  .read<ChangePhoneVerifyCurrentPhoneCubit>()
                  .verify(code);
            },
            onResend: _onResend,
          ),
        ),
      ),
    );
  }
}
