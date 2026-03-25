part of '../imports/view_imports.dart';

class _BillsAddButtonSection extends StatelessWidget {
  const _BillsAddButtonSection({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AppPadding.pH16,
        top: AppPadding.pH8,
      ),
      child: LoadingButton(
        title: '',
        height: AppSize.sH50,
        borderRadius: AppCircular.r15,
        color: AppColors.buttonColor,
        onTap: () async => onPressed(),
        titleAsWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconWidget(
              icon: AppAssets.svg.wzeinIcons.add01.path,
              height: AppSize.sH22,
              width: AppSize.sW20,
              color: AppColors.white,
            ),
            AppMargin.mW8.szW,
            Text(
              LocaleKeys.billsAddNewBill.tr(),
              style: const TextStyle().setWhiteColor.s14.semiBold,
            ),
          ],
        ),
      ),
    );
  }
}
