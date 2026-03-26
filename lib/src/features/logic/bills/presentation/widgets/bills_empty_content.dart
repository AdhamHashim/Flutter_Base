part of '../imports/view_imports.dart';

class _BillsEmptyContent extends StatelessWidget {
  const _BillsEmptyContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppPadding.pH35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: AppSize.sH85,
            height: AppSize.sH85,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              color: AppColors.selectedButton,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconWidget(
                icon: AppAssets.svg.wzeinIcons.file.path,
                height: AppSize.sH35,
                width: AppSize.sW30,
                // color: AppColors.hintText,
              ),
            ),
          ),
          AppMargin.mH16.szH,
          Text(
            LocaleKeys.billsEmptyTitle.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle().setMainTextColor.s16.semiBold,
          ),
          AppMargin.mH8.szH,
          Text(
            LocaleKeys.billsEmptyDesc.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle().setPrimaryColor.s14.regular,
          ).paddingSymmetric(horizontal: AppPadding.pW16),
          AppMargin.mH20.szH,
          LoadingButton(
            title: LocaleKeys.billsAddBill.tr(),
            width: context.width * 0.45,
            height: AppSize.sH45,
            borderRadius: AppCircular.r12,
            color: AppColors.buttonColor,
            onTap: () async =>
                _BillFormSheet.show(context, mode: BillFormMode.add),
          ),
        ],
      ),
    );
  }
}
