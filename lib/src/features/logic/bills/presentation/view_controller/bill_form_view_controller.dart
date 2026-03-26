import 'package:flutter/material.dart';

import '../../../../../core/extensions/form_mixin.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../entity/bill_entity.dart';

enum BillFormMode { add, edit }

class BillFormViewController with FormMixin {
  BillFormViewController();

  factory BillFormViewController.fromBill(BillEntity bill) {
    final vc = BillFormViewController();
    vc.amountController.text = bill.amount == 0 ? '' : bill.amount.toString();
    vc.itemTypeController.text = bill.itemType;
    vc.purchaseDateController.text = bill.purchaseDate;
    vc.warrantyEndController.text = bill.warrantyEndDate;
    vc.attachmentLabel.value =
        bill.attachmentName.isEmpty ? null : bill.attachmentName;
    return vc;
  }

  final TextEditingController amountController = TextEditingController();
  final TextEditingController itemTypeController = TextEditingController();
  final TextEditingController purchaseDateController = TextEditingController();
  final TextEditingController warrantyEndController = TextEditingController();
  final ValueNotifier<String?> attachmentLabel = ValueNotifier<String?>(null);

  void setAttachmentName(String? name) {
    attachmentLabel.value = name;
  }

  BillEntity toBill({BillEntity? existing}) {
    final parsed =
        double.tryParse(amountController.text.toEnglishNumbers().trim()) ?? 0.0;
    final attach = attachmentLabel.value?.trim() ?? '';
    return BillEntity(
      id: existing?.id ?? 0,
      displayNumber: existing?.displayNumber ?? '',
      amount: parsed,
      itemType: itemTypeController.text.trim(),
      purchaseDate: purchaseDateController.text.trim(),
      warrantyEndDate: warrantyEndController.text.trim(),
      attachmentName: attach,
    );
  }

  void dispose() {
    amountController.dispose();
    itemTypeController.dispose();
    purchaseDateController.dispose();
    warrantyEndController.dispose();
    attachmentLabel.dispose();
  }
}
