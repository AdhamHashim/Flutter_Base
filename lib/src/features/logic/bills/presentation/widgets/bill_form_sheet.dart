part of '../imports/view_imports.dart';

class _BillFormSheet extends StatefulWidget {
  const _BillFormSheet({
    required this.mode,
    this.bill,
  });

  final BillFormMode mode;
  final BillEntity? bill;

  static Future<void> show(
    BuildContext context, {
    required BillFormMode mode,
    BillEntity? bill,
  }) async {
    final cubit = context.read<BillsCubit>();
    await showDefaultBottomSheet(
      context: context,
      child: BlocProvider<BillsCubit>.value(
        value: cubit,
        child: _BillFormSheet(mode: mode, bill: bill),
      ),
    );
  }

  @override
  State<_BillFormSheet> createState() => _BillFormSheetState();
}

class _BillFormSheetState extends State<_BillFormSheet> {
  late final BillFormViewController _vc;

  @override
  void initState() {
    super.initState();
    _vc = widget.bill != null
        ? BillFormViewController.fromBill(widget.bill!)
        : BillFormViewController();
  }

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final picked = await showDatePicker(
      locale: Languages.currentLanguage.locale,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (ctx, child) {
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.forth,
              onPrimary: AppColors.white,
              onSurface: AppColors.main,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final formatted = DateFormat(
        'dd/MM/yyyy',
        Languages.currentLanguage.locale.languageCode,
      ).format(picked);
      controller.text = formatted;
    }
  }

  Future<void> _pickAttachment() async {
    final file = await ImageHelper.pickImage();
    if (!mounted) return;
    if (file == null) return;
    _vc.setAttachmentName(file.path.split(Platform.pathSeparator).last);
  }

  String? _validateAmount(String? v) {
    final empty = Validators.validateEmpty(v);
    if (empty != null) return empty;
    if (double.tryParse(v!.toEnglishNumbers().trim()) == null) {
      return LocaleKeys.validationInvalidNumber;
    }
    return null;
  }

  Future<void> _onSubmit() async {
    if (!_vc.validateAndScroll()) return;
    final cubit = context.read<BillsCubit>();
    final built = _vc.toBill(existing: widget.bill);
    if (widget.mode == BillFormMode.add) {
      cubit.addBill(built);
    } else if (widget.bill != null) {
      cubit.updateBill(
        built.copyWith(
          id: widget.bill!.id,
          displayNumber: widget.bill!.displayNumber,
        ),
      );
    }
    Go.back();
    await Future<void>.delayed(Duration.zero);
    if (!Go.context.mounted) return;
    await showDefaultBottomSheet(
      child: const _BillSuccessSheetBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAdd = widget.mode == BillFormMode.add;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.pW16),
      child: Form(
        key: _vc.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isAdd
                  ? LocaleKeys.billsSheetAddTitle.tr()
                  : LocaleKeys.billsSheetEditTitle.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle().setMainTextColor.s14.semiBold,
            ),
            AppMargin.mH16.szH,
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                LocaleKeys.billsFieldInvoice.tr(),
                style: const TextStyle().setSecondryColor.s13.semiBold,
              ),
            ),
            AppMargin.mH8.szH,
            ValueListenableBuilder<String?>(
              valueListenable: _vc.attachmentLabel,
              builder: (context, attach, _) {
                return GestureDetector(
                  onTap: _pickAttachment,
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      radius: Radius.circular(AppCircular.r15),
                      color: AppColors.grey2,
                      strokeWidth: 2,
                      dashPattern: const [6, 4],
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(minHeight: AppSize.sH70),
                      padding: EdgeInsets.symmetric(
                        vertical: AppPadding.pH16,
                        horizontal: AppPadding.pW12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardFill,
                        borderRadius: BorderRadius.circular(AppCircular.r15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.billsTapToAddImage.tr(),
                                  textAlign: TextAlign.center,
                                  style:
                                      const TextStyle().setPrimaryColor.s13.medium,
                                ),
                                AppMargin.mH4.szH,
                                Text(
                                  LocaleKeys.billsUploadFormats.tr(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle().setHintColor.s12.regular,
                                ),
                                if (attach != null && attach.isNotEmpty) ...[
                                  AppMargin.mH4.szH,
                                  Text(
                                    attach,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle().setMainTextColor.s11.regular,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Container(
                            width: AppSize.sH40,
                            height: AppSize.sH40,
                            decoration: const BoxDecoration(
                              color: AppColors.selectedButton,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: IconWidget(
                                icon: AppAssets.svg.wzeinIcons.add01.path,
                                height: AppSize.sH20,
                                width: AppSize.sW20,
                                color: AppColors.hintText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            AppMargin.mH16.szH,
            CustomTextFiled(
              title: LocaleKeys.billsFieldAmount.tr(),
              hint: LocaleKeys.billsHintAmount.tr(),
              controller: _vc.amountController,
              textInputType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              validator: _validateAmount,
              inputFormatters: [
                ArabicNumbersFormatter(),
                DecimalNumberFormatter(decimalPlaces: 2),
              ],
            ),
            AppMargin.mH12.szH,
            CustomTextFiled(
              title: LocaleKeys.billsFieldItemType.tr(),
              hint: LocaleKeys.billsHintItemType.tr(),
              controller: _vc.itemTypeController,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: Validators.validateEmpty,
              inputFormatters: [TextWithNumberFormatter(allowArabic: true)],
            ),
            AppMargin.mH12.szH,
            CustomTextFiled(
              title: LocaleKeys.billsFieldPurchaseDate.tr(),
              hint: LocaleKeys.billsHintDate.tr(),
              controller: _vc.purchaseDateController,
              textInputType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              readOnly: true,
              onTap: () => _pickDate(_vc.purchaseDateController),
              validator: Validators.validateEmpty,
            ),
            AppMargin.mH12.szH,
            CustomTextFiled(
              title: LocaleKeys.billsFieldWarrantyEnd.tr(),
              hint: LocaleKeys.billsHintDate.tr(),
              controller: _vc.warrantyEndController,
              textInputType: TextInputType.datetime,
              textInputAction: TextInputAction.done,
              readOnly: true,
              onTap: () => _pickDate(_vc.warrantyEndController),
              validator: Validators.validateEmpty,
            ),
            AppMargin.mH20.szH,
            LoadingButton(
              title: isAdd
                  ? LocaleKeys.billsSaveBill.tr()
                  : LocaleKeys.billsSaveEdit.tr(),
              height: AppSize.sH60,
              borderRadius: AppCircular.r15,
              color: AppColors.buttonColor,
              onTap: _onSubmit,
            ),
            AppMargin.mH16.szH,
          ],
        ),
      ),
    );
  }
}
