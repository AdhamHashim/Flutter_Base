import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../entity/bill_entity.dart';
import 'bills_state.dart';

@injectable
class BillsCubit extends Cubit<BillsState> {
  BillsCubit() : super(const BillsState());

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  int _nextId() {
    if (state.bills.isEmpty) return 1;
    return state.bills
            .map((e) => e.id)
            .reduce((a, b) => a > b ? a : b) +
        1;
  }

  void addBill(BillEntity bill) {
    final withId = bill.id == 0 ? bill.copyWith(id: _nextId()) : bill;
    final display =
        withId.displayNumber.isEmpty ? '${withId.id}' : withId.displayNumber;
    emit(state.copyWith(bills: [withId.copyWith(displayNumber: display), ...state.bills]));
  }

  void updateBill(BillEntity updated) {
    emit(
      state.copyWith(
        bills: state.bills.map((e) => e.id == updated.id ? updated : e).toList(),
      ),
    );
  }

  void removeBill(int id) {
    emit(state.copyWith(bills: state.bills.where((e) => e.id != id).toList()));
  }
}
