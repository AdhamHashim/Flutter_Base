part of '../imports/view_imports.dart';

class _RegisterPinBody extends StatefulWidget {
  const _RegisterPinBody({
    required this.title,
    required this.subtitle,
    required this.onConfirm,
  });
  final String title;
  final String subtitle;
  final Future<void> Function(String pin) onConfirm;

  @override
  State<_RegisterPinBody> createState() => _RegisterPinBodyState();
}

class _RegisterPinBodyState extends State<_RegisterPinBody> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
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
              title: widget.title,
              subtitle: widget.subtitle,
            ),
            AppSize.sH20.szH,
            CustomPinTextField(
              controller: _pinController,
              length: 6,
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
              onTap: () async {
                if (_pinController.text.length != 6) return;
                await widget.onConfirm(_pinController.text);
              },
            ),
          ],
        ).paddingSymmetric(horizontal: AppPadding.pW14),
      ),
    );
  }
}
