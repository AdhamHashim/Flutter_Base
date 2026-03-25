part of '../imports/view_imports.dart';

class _BillCardWidget extends StatelessWidget {
  const _BillCardWidget({
    required this.bill,
    required this.onEdit,
    required this.onDelete,
  });

  final BillEntity bill;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),
      decoration: BoxDecoration(
        color: AppColors.cardFill,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bill.displayNumber,
                      style: const TextStyle().setMainTextColor.s14.semiBold,
                    ),
                    AppMargin.mH4.szH,
                    RiyalPriceText(
                      price: bill.amount.toStringAsFixed(
                        bill.amount == bill.amount.roundToDouble() ? 0 : 2,
                      ),
                      priceTextStyle:
                          const TextStyle().setColor(AppColors.forth).s16.semiBold,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Semantics(
                    label: LocaleKeys.billsDeleteSemantics.tr(),
                    button: true,
                    child: Material(
                      color: AppColors.error.withValues(alpha: 0.12),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: onDelete,
                        child: Padding(
                          padding: EdgeInsets.all(AppPadding.pH8),
                          child: Center(
                            child: IconWidget(
                              icon: AppAssets.svg.wzeinIcons.delete02.path,
                              height: AppSize.sH20,
                              width: AppSize.sW20,
                              color: AppColors.error,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppMargin.mW8.szW,
                  Semantics(
                    label: LocaleKeys.billsEditSemantics.tr(),
                    button: true,
                    child: Material(
                      color: AppColors.success.withValues(alpha: 0.12),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: onEdit,
                        child: Padding(
                          padding: EdgeInsets.all(AppPadding.pH8),
                          child: Center(
                            child: IconWidget(
                              icon: AppAssets.svg.baseSvg.changeEmail.path,
                              height: AppSize.sH20,
                              width: AppSize.sW20,
                              color: AppColors.success,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          AppMargin.mH12.szH,
          _BillInfoLine(
            icon: AppAssets.svg.wzeinIcons.aX338Expenses.path,
            text: LocaleKeys.billsPurchaseDateLabel(date: bill.purchaseDate),
          ),
          AppMargin.mH8.szH,
          _BillInfoLine(
            icon: AppAssets.svg.wzeinIcons.circlePassword.path,
            text: LocaleKeys.billsWarrantyEndLabel(date: bill.warrantyEndDate),
          ),
          if (bill.attachmentName.isNotEmpty) ...[
            AppMargin.mH8.szH,
            _BillInfoLine(
              icon: AppAssets.svg.wzeinIcons.add01.path,
              text: LocaleKeys.billsAttachmentLabel(name: bill.attachmentName),
            ),
          ],
        ],
      ),
    );
  }
}

class _BillInfoLine extends StatelessWidget {
  const _BillInfoLine({required this.icon, required this.text});

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconWidget(
          icon: icon,
          height: AppSize.sH18,
          width: AppSize.sW18,
          color: AppColors.hintText,
        ),
        AppMargin.mW8.szW,
        Expanded(
          child: Text(
            text,
            style: const TextStyle().setPrimaryColor.s12.regular,
          ),
        ),
      ],
    );
  }
}
