part of '../imports/view_imports.dart';

class ChangePhoneVerifyNewPhoneScreen extends StatelessWidget {
  const ChangePhoneVerifyNewPhoneScreen({super.key, required this.smsBody});

  final ChangePhoneSmsBody smsBody;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injector<ChangePhoneVerifyNewPhoneCubit>(),
        ),
        BlocProvider(
          create: (_) => injector<ChangePhoneSendSmsToNewCubit>(),
        ),
      ],
      child: _ChangePhoneVerifyNewView(smsBody: smsBody),
    );
  }
}

class _ChangePhoneVerifyNewView extends StatefulWidget {
  const _ChangePhoneVerifyNewView({required this.smsBody});

  final ChangePhoneSmsBody smsBody;

  @override
  State<_ChangePhoneVerifyNewView> createState() =>
      _ChangePhoneVerifyNewViewState();
}

class _ChangePhoneVerifyNewViewState extends State<_ChangePhoneVerifyNewView> {
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
    final cubit = context.read<ChangePhoneSendSmsToNewCubit>();
    await cubit.sendSmsToNewPhone(widget.smsBody);
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
    final masked = changePhoneMaskedDisplay(widget.smsBody.phone);
    return BlocListener<ChangePhoneVerifyNewPhoneCubit, AsyncState<UserModel>>(
      listenWhen: (p, c) => c.isSuccess && !p.isSuccess,
      listener: (context, state) {
        Future<void> handle() async {
          await UserCubit.instance.updateUser(state.data);
          if (!context.mounted) return;
          await showChangePhoneSuccessSheet();
        }

        handle();
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child: _ChangePhoneOtpBody(
            vc: _vc,
            subtitleText: LocaleKeys.changePhoneOtpSubtitleMasked(
              masked: masked.isEmpty ? widget.smsBody.phone : masked,
            ),
            onConfirm: () async {
              final code = _vc.otpController.text.toEnglishNumbers();
              if (code.length != 4) {
                MessageUtils.showSnackBar(
                  baseStatus: BaseStatus.error,
                  message: LocaleKeys.emptyOtpRequired,
                );
                return;
              }
              final body = ChangePhoneVerifyNewBody(
                countryCode: widget.smsBody.countryCode,
                phone: widget.smsBody.phone,
                code: code,
              );
              await context.read<ChangePhoneVerifyNewPhoneCubit>().verify(body);
            },
            onResend: _onResend,
          ),
        ),
      ),
    );
  }
}
