import 'package:flutter/material.dart';

class SubscriptionsViewController {
  final TextEditingController discountController = TextEditingController();
  final ValueNotifier<bool> isYearly = ValueNotifier<bool>(false);

  void dispose() {
    discountController.dispose();
    isYearly.dispose();
  }
}
