part of '../../imports/view_imports.dart';

Future<void> deleteNotifications({
  required DeleteNotificationCubit cubit,
  required String title,
  String? message,
  required Future<void> Function() onConfirm,
}) {
  return showDefaultBottomSheet(
    child: BlocProvider.value(
      value: cubit,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: _NotificationDeleteSheetBody(
          title: title,
          message: message,
          onConfirm: onConfirm,
        ),
      ),
    ),
  );
}

class _NotificationDeleteSheetBody extends StatelessWidget {
  const _NotificationDeleteSheetBody({
    required this.title,
    required this.onConfirm,
    this.message,
  });

  final String title;
  final String? message;
  final Future<void> Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: AppSize.sW60,
            height: AppSize.sH4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(AppCircular.r12),
            ),
          ),
        ),
        AppSize.sH20.szH,
        Center(
          child: IconWidget(
            icon: AppAssets.svg.baseSvg.notificationDelete.path,
            width: AppSize.sW30,
            height: AppSize.sH30,
            color: AppColors.error,
          ),
        ),
        AppSize.sH16.szH,
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle().setMainTextColor.s14.semiBold,
        ),
        if (message != null && message!.isNotEmpty) ...[
          AppSize.sH12.szH,
          Text(
            message!,
            textAlign: TextAlign.center,
            style: const TextStyle().setHintColor.s13.regular,
          ),
        ],
        AppSize.sH20.szH,
        Row(
          children: [
            Expanded(
              child: DefaultButton(
                width: double.infinity,
                height: AppSize.sH55,
                title: LocaleKeys.back,
                color: AppColors.grey1,
                textColor: AppColors.primary,
                borderRadius: BorderRadius.circular(AppCircular.r15),
                onTap: () => Go.back(),
              ),
            ),
            AppMargin.mW8.szW,
            Expanded(
              child: LoadingButton(
                height: AppSize.sH55,
                borderRadius: AppCircular.r15,
                title: LocaleKeys.notificationsDeleteAction,
                color: AppColors.white,
                textColor: AppColors.error,
                borderSide: const BorderSide(color: AppColors.error),
                onTap: onConfirm,
              ),
            ),
          ],
        ),
      ],
    ).paddingSymmetric(
      horizontal: AppPadding.pW20,
      vertical: AppPadding.pH8,
    );
  }
}
