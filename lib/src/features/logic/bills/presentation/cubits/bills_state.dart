import 'package:equatable/equatable.dart';

import '../../entity/bill_entity.dart';

class BillsState extends Equatable {
  final List<BillEntity> bills;
  final String searchQuery;

  const BillsState({
    this.bills = const [],
    this.searchQuery = '',
  });

  BillsState copyWith({
    List<BillEntity>? bills,
    String? searchQuery,
  }) {
    return BillsState(
      bills: bills ?? this.bills,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<BillEntity> get visibleBills {
    final q = searchQuery.trim().toLowerCase();
    if (q.isEmpty) return bills;
    return bills.where((b) {
      return b.displayNumber.toLowerCase().contains(q) ||
          b.itemType.toLowerCase().contains(q) ||
          b.attachmentName.toLowerCase().contains(q);
    }).toList();
  }

  @override
  List<Object?> get props => [bills, searchQuery];
}
