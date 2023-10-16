import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_app/db_model/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionData {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime selectedDate;
  @HiveField(3)
  final CategoryType selectedCategoryType;
  @HiveField(4)
  final CategoryData model;
  @HiveField(5)
  String? id;

  TransactionData(
      {required this.purpose,
      required this.amount,
      required this.selectedDate,
      required this.selectedCategoryType,
      required this.model}) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  String toString() {
    return '$purpose $amount $selectedDate';
  }
}
