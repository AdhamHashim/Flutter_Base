part of '../imports/view_imports.dart';

class _LoginConfirmPinBody extends StatefulWidget {
  const _LoginConfirmPinBody();

  @override
  State<_LoginConfirmPinBody> createState() => _LoginConfirmPinBodyState();
}

class _LoginConfirmPinBodyState extends State<_LoginConfirmPinBody> {
  late final LoginPinViewController _vc = LoginPinViewController();

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RegisterHeaderWidget(
            title: LocaleKeys.registerConfirmPinTitle,
            subtitle: LocaleKeys.registerConfirmPinSubtitle,
          ),
          AppSize.sH20.szH,
          CustomPinTextField(
            controller: _vc.pinController,
            length: 7,
            onCompleted: (_) {},
          ),
          AppSize.sH20.szH,
          RegisterAutoLockInfoWidget(
            title: LocaleKeys.registerAutoLockTitle,
            description: LocaleKeys.registerAutoLockDesc,
          ),
          AppSize.sH30.szH,
          LoadingButton(
            title: LocaleKeys.confirm,
            color: AppColors.forth,
            borderRadius: AppCircular.r20,
            height: AppSize.sH55,
            onTap: () async {
              if (_vc.pinController.text.length != 7) return;
              await Future<void>.delayed(const Duration(milliseconds: 400));
              if (!context.mounted) return;
              Go.to(const RegisterFinancialDataScreen());
            },
          ),
        ],
      ).paddingSymmetric(horizontal: AppPadding.pW14),
    );
  }
}
