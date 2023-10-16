import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_management_app/screens/AddTransaction/screen_add_transaction.dart';
import 'package:money_management_app/screens/category/category_popup.dart';
import 'package:money_management_app/screens/category/screen_category.dart';

import 'package:money_management_app/screens/home/widgets/bottomnavigation.dart';
import 'package:money_management_app/screens/transactions/screen_transactions.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  static ValueNotifier<int> bottomnavNotifier = ValueNotifier(0);
  final _pages = [
    TransactionScreen(),
    CategoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MONEY MANAGEMENT APP'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: MoneyManagementBottomNavigation(),
      body: ValueListenableBuilder(
        valueListenable: bottomnavNotifier,
        builder: (context, value, child) {
          return SafeArea(child: _pages[bottomnavNotifier.value]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (bottomnavNotifier.value == 0) {
            Navigator.of(context).pushNamed(ScreenAddTransaction().routeName);
          } else if (bottomnavNotifier.value == 1) {
            categoryPopUp(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
