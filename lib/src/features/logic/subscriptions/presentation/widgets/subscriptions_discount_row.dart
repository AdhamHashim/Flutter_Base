part of '../imports/view_imports.dart';

class _SubscriptionsDiscountRow extends StatelessWidget {
  const _SubscriptionsDiscountRow({required this.vc});

  final SubscriptionsViewController vc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.subscriptionsDiscountLabel,
          style: const TextStyle().setMainTextColor.s13.medium,
        ),
        AppMargin.mH8.szH,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DefaultTextField(
                controller: vc.discountController,
                title: LocaleKeys.subscriptionsDiscountHint,
                textAlign: TextAlign.start,
                borderRadius: BorderRadius.circular(AppCircular.r12),
                fillColor: AppColors.white,
                borderColor: AppColors.selectedButton,
                contentPadding: EdgeInsetsDirectional.only(
                  start: AppPadding.pW16,
                  end: AppPadding.pW16,
                  top: AppPadding.pH12,
                  bottom: AppPadding.pH12,
                ),
              ),
            ),
            AppMargin.mW8.szW,
            SizedBox(
              width: AppSize.sW70,
              height: AppSize.sH50,
              child: DefaultButton(
                title: LocaleKeys.subscriptionsDiscountApply,
                onTap: () {
                  MessageUtils.showSnackBar(
                    baseStatus: BaseStatus.success,
                    message: LocaleKeys.subscriptionsDiscountApplied,
                  );
                },
                height: AppSize.sH50,
                width: AppSize.sW70,
                borderRadius: BorderRadius.circular(AppCircular.r12),
                fontSize: FontSizeManager.s14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
