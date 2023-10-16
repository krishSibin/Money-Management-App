import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_app/db_model/transaction/transaction_model.dart';

final TRANSACTION_DB = 'transaction_db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionData data);
  Future<List<TransactionData>> getTransaction();
  Future<void> deleteTransaction(String id);
}

class TransactionDB extends TransactionDbFunctions {
  TransactionDB._internal();
  static final TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }
  ValueNotifier<List<TransactionData>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionData data) async {
    final model = await Hive.openBox<TransactionData>(TRANSACTION_DB);
    model.put(data.id, data);
    refresh();
  }

  @override
  Future<List<TransactionData>> getTransaction() async {
    final transModel = await Hive.openBox<TransactionData>(TRANSACTION_DB);
    return transModel.values.toList();
  }

  Future<void> refresh() async {
    transactionListNotifier.value.clear();
    final myList = await getTransaction();
    myList.sort(
        (first, second) => first.selectedDate.compareTo(second.selectedDate));

    transactionListNotifier.value.addAll(myList);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final transModel = await Hive.openBox<TransactionData>(TRANSACTION_DB);
    transModel.delete(id);
    refresh();
  }
}
