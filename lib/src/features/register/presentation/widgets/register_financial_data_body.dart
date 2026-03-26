part of '../imports/view_imports.dart';

class _RegisterFinancialDataBody extends StatefulWidget {
  const _RegisterFinancialDataBody();

  @override
  State<_RegisterFinancialDataBody> createState() =>
      _RegisterFinancialDataBodyState();
}

class _RegisterFinancialDataBodyState
    extends State<_RegisterFinancialDataBody> {
  final TextEditingController _monthlySalaryController =
      TextEditingController();
  final TextEditingController _salaryDateController = TextEditingController();
  final TextEditingController _dailyExpenseController = TextEditingController();
  final TextEditingController _holidayExpenseController =
      TextEditingController();
  final ValueNotifier<Set<int>> _selectedWeekdays = ValueNotifier({5, 6});

  static const List<int> _weekdayIndices = [6, 5, 4, 3, 2, 1, 0];

  String _getWeekdayLabel(int index) {
    switch (index) {
      case 0:
        return LocaleKeys.registerSunday;
      case 1:
        return LocaleKeys.registerMonday;
      case 2:
        return LocaleKeys.registerTuesday;
      case 3:
        return LocaleKeys.registerWednesday;
      case 4:
        return LocaleKeys.registerThursday;
      case 5:
        return LocaleKeys.registerFriday;
      case 6:
        return LocaleKeys.registerSaturday;
      default:
        return '';
    }
  }

  @override
  void dispose() {
    _monthlySalaryController.dispose();
    _salaryDateController.dispose();
    _dailyExpenseController.dispose();
    _holidayExpenseController.dispose();
    _selectedWeekdays.dispose();
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
            title: LocaleKeys.registerFinancialDataTitle,
            subtitle: LocaleKeys.registerFinancialDataSubtitle,
          ),
          AppSize.sH20.szH,
          CustomTextFiled(
            title: LocaleKeys.registerMonthlySalaryLabel,
            hint: '0.00',
            controller: _monthlySalaryController,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            validator: (v) => Validators.noValidate(v ?? ''),
            inputFormatters: [
              DecimalNumberFormatter(decimalPlaces: 2),
              ArabicNumbersFormatter(),
            ],
            prefixIcon: IconWidget(
              icon: AppAssets.svg.wzeinIcons.currency.path,
              height: AppSize.sH20,
              width: AppSize.sW20,
            ).paddingAll(AppPadding.pW4),
          ),
          AppSize.sH20.szH,
          CustomTextFiled(
            title: LocaleKeys.registerSalaryDateLabel,
            hint: 'dd/mm/yyyy',
            controller: _salaryDateController,
            textInputType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            validator: (v) => Validators.noValidate(v ?? ''),
            onTap: () => showCustomDatePicker(
              controller: _salaryDateController,
              dateFormat: 'dd/MM/yyyy',
            ),
            readOnly: true,
            fillColor: AppColors.white,
            prefixIcon: IconWidget(
              icon: AppAssets.svg.wzeinIcons.currency.path,
              height: AppSize.sH20,
              width: AppSize.sW20,
            ).paddingAll(AppPadding.pW4),
          ),
          AppSize.sH20.szH,
          CustomTextFiled(
            title: LocaleKeys.registerDailyExpenseLabel,
            hint: '0.00',
            controller: _dailyExpenseController,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            validator: (v) => Validators.noValidate(v ?? ''),
            inputFormatters: [
              DecimalNumberFormatter(decimalPlaces: 2),
              ArabicNumbersFormatter(),
            ],
            prefixIcon: IconWidget(
              icon: AppAssets.svg.wzeinIcons.calender.path,
              height: AppSize.sH20,
              width: AppSize.sW20,
            ).paddingAll(AppPadding.pW4),
          ),
          AppSize.sH20.szH,
          CustomTextFiled(
            title: LocaleKeys.registerHolidayExpenseLabel,
            hint: '0.00',
            prefixIcon: IconWidget(
              icon: AppAssets.svg.wzeinIcons.sun.path,
              height: AppSize.sH20,
              width: AppSize.sW20,
            ).paddingAll(AppPadding.pW4),
            controller: _holidayExpenseController,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.done,
            validator: (v) => Validators.noValidate(v ?? ''),
            inputFormatters: [
              DecimalNumberFormatter(decimalPlaces: 2),
              ArabicNumbersFormatter(),
            ],
          ),
          AppSize.sH20.szH,
          Text(
            LocaleKeys.registerWeekdaysLabel,
            style:
                const TextStyle().setMainTextColor.s14.semiBold.setFontFamily,
          ),
          AppSize.sH8.szH,
          ValueListenableBuilder<Set<int>>(
            valueListenable: _selectedWeekdays,
            builder: (context, selected, child) {
              return Wrap(
                spacing: AppMargin.mW8,
                runSpacing: AppMargin.mH8,
                children: _weekdayIndices.map((index) {
                  final isSelected = selected.contains(index);
                  return GestureDetector(
                    onTap: () {
                      final newSet = Set<int>.from(selected);
                      if (isSelected) {
                        newSet.remove(index);
                      } else {
                        newSet.add(index);
                      }
                      _selectedWeekdays.value = newSet;
                    },
                    child: Container(
                      width: AppSize.sH45,
                      height: AppSize.sH45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.forth : AppColors.grey1,
                        borderRadius: BorderRadius.circular(AppCircular.r12),
                      ),
                      child: Text(
                        _getWeekdayLabel(index),
                        textAlign: TextAlign.center,
                        style: isSelected
                            ? const TextStyle()
                                  .setWhiteColor
                                  .s12
                                  .regular
                                  .setFontFamily
                            : const TextStyle()
                                  .setPrimaryColor
                                  .s12
                                  .regular
                                  .setFontFamily,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          AppSize.sH8.szH,
          Text(
            LocaleKeys.registerWeekdaysHelper,
            style: const TextStyle().setHintColor.s12.regular.setFontFamily,
          ),
          AppSize.sH20.szH,
          RegisterAutoLockInfoWidget(
            title: LocaleKeys.registerNoticeTitle,
            description: LocaleKeys.registerNoticeDesc,
            iconPath: AppAssets.svg.wzeinIcons.lamp.path,
          ),
          AppSize.sH30.szH,
          LoadingButton(
            title: LocaleKeys.confirm,
            color: AppColors.forth,
            borderRadius: AppCircular.r20,
            onTap: () async {
              await Future.delayed(const Duration(milliseconds: 400));
              if (!context.mounted) return;
              Go.offAll(const HomeScreen());
            },
          ),
        ],
      ).paddingSymmetric(horizontal: AppPadding.pW14),
    );
  }
}
