import 'package:flutter/material.dart';

import '../../entity/reports_ui_model.dart';

class ReportsViewController {
  ReportsViewController() {
    dateFromController.text = '';
    dateToController.text = '';
  }

  final ValueNotifier<ReportsPeriod> period = ValueNotifier(ReportsPeriod.daily);
  final ValueNotifier<ReportsChartMode> chartMode = ValueNotifier(ReportsChartMode.byDay);

  final TextEditingController dateFromController = TextEditingController();
  final TextEditingController dateToController = TextEditingController();

  void dispose() {
    period.dispose();
    chartMode.dispose();
    dateFromController.dispose();
    dateToController.dispose();
  }
}
