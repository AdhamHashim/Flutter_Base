import 'package:equatable/equatable.dart';

class BillEntity extends Equatable {
  final int id;
  final String displayNumber;
  final double amount;
  final String itemType;
  final String purchaseDate;
  final String warrantyEndDate;
  final String attachmentName;

  const BillEntity({
    required this.id,
    required this.displayNumber,
    required this.amount,
    required this.itemType,
    required this.purchaseDate,
    required this.warrantyEndDate,
    required this.attachmentName,
  });

  factory BillEntity.initial() => const BillEntity(
        id: 0,
        displayNumber: '',
        amount: 0,
        itemType: '',
        purchaseDate: '',
        warrantyEndDate: '',
        attachmentName: '',
      );

  factory BillEntity.fromJson(Map<String, dynamic> json) => BillEntity(
        id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
        displayNumber: json['display_number']?.toString() ?? '',
        amount: double.tryParse(json['amount']?.toString() ?? '') ?? 0.0,
        itemType: json['item_type']?.toString() ?? '',
        purchaseDate: json['purchase_date']?.toString() ?? '',
        warrantyEndDate: json['warranty_end_date']?.toString() ?? '',
        attachmentName: json['attachment_name']?.toString() ?? '',
      );

  BillEntity copyWith({
    int? id,
    String? displayNumber,
    double? amount,
    String? itemType,
    String? purchaseDate,
    String? warrantyEndDate,
    String? attachmentName,
  }) {
    return BillEntity(
      id: id ?? this.id,
      displayNumber: displayNumber ?? this.displayNumber,
      amount: amount ?? this.amount,
      itemType: itemType ?? this.itemType,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      warrantyEndDate: warrantyEndDate ?? this.warrantyEndDate,
      attachmentName: attachmentName ?? this.attachmentName,
    );
  }

  @override
  List<Object?> get props => [
        id,
        displayNumber,
        amount,
        itemType,
        purchaseDate,
        warrantyEndDate,
        attachmentName,
      ];
}
