import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/db/transaction/transaction_db.dart';
import 'package:money_management_app/db_model/category/category_model.dart';

import '../../db/category/category_db.dart';
import '../../db_model/transaction/transaction_model.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refresh();
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder:
            (BuildContext context, List<TransactionData> newList, Widget? _) {
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemBuilder: (BuildContext context, int index) {
              final data = newList[index];
              return Slidable(
                key: Key(data.id!),
                startActionPane: ActionPane(motion: ScrollMotion(), children: [
                  Text(
                    'Want to Delete ?',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  SlidableAction(
                    flex: 2,
                    onPressed: (ctx) {
                      TransactionDB.instance.deleteTransaction(data.id!);
                    },
                    icon: Icons.delete,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ]),
                child: Column(
                  children: [
                    Card(
                      elevation: 0,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              data.selectedCategoryType == CategoryType.income
                                  ? Colors.green
                                  : Colors.red,
                          child: Text(
                            dateParse(data.selectedDate),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        title: Text('${data.amount}'),
                        subtitle: Text(data.purpose),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 8,
              );
            },
            itemCount: newList.length,
          );
        });
  }

  String dateParse(DateTime date) {
    final dateValue = DateFormat.MMMd().format(date);
    final dateList = dateValue.split(' ');

    return '${dateList.last}\n${dateList.first}';
  }
}
