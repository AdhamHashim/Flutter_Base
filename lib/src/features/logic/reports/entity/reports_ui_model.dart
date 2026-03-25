/// UI-only models for Reports tab (Figma nodes 12295:1505, 12295:4099, sheet 12323:2996).
enum ReportsPeriod { daily, weekly, monthly }

enum ReportsChartMode { byDay, byCategory }

enum ReportsSavingsKind { daily, weekly, monthly }

enum ReportsPieCategory { food, transport, utilities, health, other }

class ReportsSavingsItem {
  const ReportsSavingsItem({
    required this.kind,
    required this.amountDigits,
    required this.progress,
    required this.isPositive,
    required this.percentDigits,
  });

  final ReportsSavingsKind kind;
  final String amountDigits;
  final double progress;
  final bool isPositive;
  final String percentDigits;
}

class ReportsDayBarItem {
  const ReportsDayBarItem({required this.dayOffsetFromSaturday, required this.amount});

  /// 0 = Saturday … 6 = Friday (matches common Arabic week layout in design).
  final int dayOffsetFromSaturday;
  final double amount;
}

class ReportsPieSlice {
  const ReportsPieSlice({
    required this.category,
    required this.amount,
    required this.percent,
  });

  final ReportsPieCategory category;
  final double amount;
  final double percent;
}

class ReportsFixedMonthRow {
  const ReportsFixedMonthRow({
    required this.month,
    required this.amountDigits,
    this.deltaPercent,
    this.deltaPositive = true,
  });

  final int month;
  final String amountDigits;
  final double? deltaPercent;
  final bool deltaPositive;
}

class ReportsUiModel {
  const ReportsUiModel({
    required this.totalSpendingDigits,
    required this.goalDigits,
    required this.budgetAdherencePercentDigits,
    required this.dailyAverageDigits,
    required this.savingsItems,
    required this.dayBars,
    required this.pieSlices,
    required this.fixedMonths,
    required this.thisMonthTotalDigits,
    required this.thisMonthDailyAvgDigits,
    required this.lastMonthTotalDigits,
    required this.lastMonthDailyAvgDigits,
  });

  final String totalSpendingDigits;
  final String goalDigits;
  final String budgetAdherencePercentDigits;
  final String dailyAverageDigits;
  final List<ReportsSavingsItem> savingsItems;
  final List<ReportsDayBarItem> dayBars;
  final List<ReportsPieSlice> pieSlices;
  final List<ReportsFixedMonthRow> fixedMonths;
  final String thisMonthTotalDigits;
  final String thisMonthDailyAvgDigits;
  final String lastMonthTotalDigits;
  final String lastMonthDailyAvgDigits;

  factory ReportsUiModel.initial() => const ReportsUiModel(
        totalSpendingDigits: '0',
        goalDigits: '0',
        budgetAdherencePercentDigits: '0',
        dailyAverageDigits: '0',
        savingsItems: [],
        dayBars: [],
        pieSlices: [],
        fixedMonths: [],
        thisMonthTotalDigits: '0',
        thisMonthDailyAvgDigits: '0',
        lastMonthTotalDigits: '0',
        lastMonthDailyAvgDigits: '0',
      );

  factory ReportsUiModel.mock() => const ReportsUiModel(
        totalSpendingDigits: '120',
        goalDigits: '150',
        budgetAdherencePercentDigits: '80',
        dailyAverageDigits: '120',
        savingsItems: [
          ReportsSavingsItem(
            kind: ReportsSavingsKind.daily,
            amountDigits: '30',
            progress: 0.92,
            isPositive: true,
            percentDigits: '25',
          ),
          ReportsSavingsItem(
            kind: ReportsSavingsKind.weekly,
            amountDigits: '210',
            progress: 0.4,
            isPositive: true,
            percentDigits: '20',
          ),
          ReportsSavingsItem(
            kind: ReportsSavingsKind.monthly,
            amountDigits: '900',
            progress: 0.6,
            isPositive: false,
            percentDigits: '5',
          ),
        ],
        dayBars: [
          ReportsDayBarItem(dayOffsetFromSaturday: 0, amount: 120),
          ReportsDayBarItem(dayOffsetFromSaturday: 1, amount: 200),
          ReportsDayBarItem(dayOffsetFromSaturday: 2, amount: 90),
          ReportsDayBarItem(dayOffsetFromSaturday: 3, amount: 150),
          ReportsDayBarItem(dayOffsetFromSaturday: 4, amount: 60),
          ReportsDayBarItem(dayOffsetFromSaturday: 5, amount: 180),
          ReportsDayBarItem(dayOffsetFromSaturday: 6, amount: 40),
        ],
        pieSlices: [
          ReportsPieSlice(category: ReportsPieCategory.food, amount: 450, percent: 35),
          ReportsPieSlice(category: ReportsPieCategory.transport, amount: 280, percent: 22),
          ReportsPieSlice(category: ReportsPieCategory.utilities, amount: 200, percent: 16),
          ReportsPieSlice(category: ReportsPieCategory.health, amount: 150, percent: 12),
          ReportsPieSlice(category: ReportsPieCategory.other, amount: 120, percent: 9),
        ],
        fixedMonths: [
          ReportsFixedMonthRow(month: 1, amountDigits: '3050'),
          ReportsFixedMonthRow(month: 2, amountDigits: '3050', deltaPercent: 3.3, deltaPositive: false),
          ReportsFixedMonthRow(month: 3, amountDigits: '3050', deltaPercent: 2.1, deltaPositive: true),
          ReportsFixedMonthRow(month: 4, amountDigits: '3050', deltaPercent: 1.5, deltaPositive: true),
          ReportsFixedMonthRow(month: 5, amountDigits: '3050'),
          ReportsFixedMonthRow(month: 6, amountDigits: '3050', deltaPercent: 4.0, deltaPositive: false),
        ],
        thisMonthTotalDigits: '3600',
        thisMonthDailyAvgDigits: '120',
        lastMonthTotalDigits: '3400',
        lastMonthDailyAvgDigits: '113',
      );
}
