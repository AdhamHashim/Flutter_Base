/// UI-only snapshot for the Home tab dashboard (Figma). Replace with API models later.
class HomeTabUiModel {
  const HomeTabUiModel({
    required this.notificationCount,
    required this.monthlySalaryAmount,
    required this.monthlyExpenseAmount,
    required this.todayExpenseAmount,
    required this.purchasesAmount,
    required this.billsAmount,
    required this.commitmentDailyAmount,
    required this.commitmentWeeklyAmount,
    required this.commitmentMonthlyAmount,
    required this.commitmentWeeklyProgress,
    required this.commitmentMonthlyProgress,
    required this.savingsTodayAmount,
    required this.savingsWeekAmount,
    required this.savingsMonthAmount,
  });

  final int notificationCount;
  final String monthlySalaryAmount;
  final String monthlyExpenseAmount;
  final String todayExpenseAmount;
  final String purchasesAmount;
  final String billsAmount;
  final String commitmentDailyAmount;
  final String commitmentWeeklyAmount;
  final String commitmentMonthlyAmount;
  final double commitmentWeeklyProgress;
  final double commitmentMonthlyProgress;
  final String savingsTodayAmount;
  final String savingsWeekAmount;
  final String savingsMonthAmount;

  factory HomeTabUiModel.initial() => const HomeTabUiModel(
        notificationCount: 0,
        monthlySalaryAmount: '0',
        monthlyExpenseAmount: '0',
        todayExpenseAmount: '0',
        purchasesAmount: '0',
        billsAmount: '0',
        commitmentDailyAmount: '0',
        commitmentWeeklyAmount: '0',
        commitmentMonthlyAmount: '0',
        commitmentWeeklyProgress: 0,
        commitmentMonthlyProgress: 0,
        savingsTodayAmount: '0',
        savingsWeekAmount: '0',
        savingsMonthAmount: '0',
      );

  /// Matches Figma dev node `12034:128` (UI-only).
  factory HomeTabUiModel.mock() => const HomeTabUiModel(
        notificationCount: 3,
        monthlySalaryAmount: '20000',
        monthlyExpenseAmount: '1250',
        todayExpenseAmount: '250',
        purchasesAmount: '1500',
        billsAmount: '350',
        commitmentDailyAmount: '50',
        commitmentWeeklyAmount: '500',
        commitmentMonthlyAmount: '1500',
        commitmentWeeklyProgress: 0.45,
        commitmentMonthlyProgress: 0.72,
        savingsTodayAmount: '150',
        savingsWeekAmount: '1350',
        savingsMonthAmount: '5400',
      );
}
