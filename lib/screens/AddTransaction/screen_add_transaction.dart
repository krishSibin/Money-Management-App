import 'package:flutter/material.dart';

import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db/transaction/transaction_db.dart';
import 'package:money_management_app/db_model/category/category_model.dart';
import 'package:money_management_app/db_model/transaction/transaction_model.dart';
import 'package:money_management_app/screens/category/income_category_list.dart';
import 'package:flutter/src/foundation/change_notifier.dart';

class ScreenAddTransaction extends StatefulWidget {
  const ScreenAddTransaction({super.key});
  final routeName = 'AddScreenTransaction';

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  String? categoryName;

  CategoryType value = CategoryType.income;
  final _purposeController = TextEditingController();
  final _amountController = TextEditingController();
  CategoryData? modeldata;

  @override
  Widget build(BuildContext context) {
    // CategoryDB().refreshUI();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            //purpose
            TextFormField(
              controller: _purposeController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: 'purpose'),
            ),
            const SizedBox(
              height: 20,
            ),
            //amount
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),
            const SizedBox(
              height: 20,
            ),

            //date
            ElevatedButton.icon(
              onPressed: () async {
                DateTime? _selectedDatetemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now());
                print(_selectedDate.toString());
                setState(() {
                  _selectedDate = _selectedDatetemp;
                });
              },
              icon: const Icon(Icons.date_range),
              label: Text(_selectedDate == null
                  ? 'select date'
                  : _selectedDate.toString()),
            ),
            const SizedBox(
              height: 20,
            ),

            //  category type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: value,
                        onChanged: (newValue) {
                          print(newValue);
                          if (newValue == null) {
                            return;
                          }

                          setState(() {
                            value = newValue;

                            categoryName = null;
                          });
                        }),
                    Text('Income')
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CategoryType.expense,
                        groupValue: value,
                        onChanged: (newValue) {
                          if (newValue == null) {
                            return;
                          }

                          setState(() {
                            value = newValue;

                            categoryName = null;
                          });

                          print(newValue);
                        }),
                    Text('Expense')
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            //categoryname
            DropdownButton(
                value: categoryName,
                hint: const Text('Select Category'),
                items: (value == CategoryType.income
                        ? CategoryDB.instance.incomeListNotifier
                        : CategoryDB.instance.expenseListNotifier)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      modeldata = e;
                    },
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    categoryName = newValue;
                  });
                }),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  await addTransaction();
                  final data = await TransactionDB.instance.getTransaction();
                  print(data.toString());

                  Navigator.of(context).pop();
                },
                child: const Text('submit'))
          ],
        ),
      )),
    );
  }

  Future<void> addTransaction() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _purpose = _purposeController.text;
    // ignore: no_leading_underscores_for_local_identifiers
    final _amount = _amountController.text;

    //purpose and amount
    if (_purpose.isEmpty || _amount.isEmpty) {
      return;
    }
    // ignore: no_leading_underscores_for_local_identifiers
    final _amountdouble = double.parse(_amount);

    //date
    if (_selectedDate == null) {
      return;
    }

    //category type:value

    //categorymodel:modeldata

    if (modeldata == null) {
      return;
    }

    final transactionData = TransactionData(
        purpose: _purpose,
        amount: _amountdouble,
        selectedDate: _selectedDate!,
        selectedCategoryType: value,
        model: modeldata!);
    TransactionDB.instance.addTransaction(transactionData);
  }
}
