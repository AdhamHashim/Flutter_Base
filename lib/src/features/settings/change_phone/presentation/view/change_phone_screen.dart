part of '../imports/view_imports.dart';

class ChangePhoneScreen extends StatelessWidget {
  const ChangePhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<ChangePhoneSendSmsToCurrentCubit>(),
      child: const _ChangePhoneEntryView(),
    );
  }
}

class _ChangePhoneEntryView extends StatefulWidget {
  const _ChangePhoneEntryView();

  @override
  State<_ChangePhoneEntryView> createState() => _ChangePhoneEntryViewState();
}

class _ChangePhoneEntryViewState extends State<_ChangePhoneEntryView> {
  @override
  void initState() {
    super.initState();
    Helpers.changeStatusbarColor(
      statusBarColor: AppColors.scaffoldBackground,
      statusBarIconBrightness: Brightness.dark,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ChangePhoneSendSmsToCurrentCubit>().sendSmsToCurrentPhone();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePhoneSendSmsToCurrentCubit, AsyncState<BaseModel?>>(
      listenWhen: (p, c) => c.isSuccess && !p.isSuccess,
      listener: (context, state) {
        Go.off(const ChangePhoneVerifyCurrentPhoneScreen());
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child: BlocBuilder<ChangePhoneSendSmsToCurrentCubit,
              AsyncState<BaseModel?>>(
            builder: (context, state) {
              if (state.isLoading) {
                return CustomLoading.showLoadingView();
              }
              if (state.isError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ErrorView(
                      error:
                          state.errorMessage ?? LocaleKeys.checkInternet,
                      height: MediaQuery.sizeOf(context).height * 0.35,
                      width: MediaQuery.sizeOf(context).width * 0.9,
                    ),
                    AppSize.sH16.szH,
                    LoadingButton(
                      title: LocaleKeys.retryAction,
                      color: AppColors.forth,
                      borderRadius: AppCircular.r20,
                      onTap: () => context
                          .read<ChangePhoneSendSmsToCurrentCubit>()
                          .sendSmsToCurrentPhone(),
                    ),
                  ],
                ).paddingSymmetric(horizontal: AppPadding.pW16);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
