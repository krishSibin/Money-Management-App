import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/screens/category/expense_category_list.dart';
import 'package:money_management_app/screens/category/income_category_list.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    CategoryDB.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(labelColor: Colors.black, controller: tabController, tabs: [
          Tab(
            text: 'INCOME',
          ),
          Tab(
            text: 'EXPENSE',
          )
        ]),
        Expanded(
          child: TabBarView(controller: tabController, children: [
            IncomeList(),
            ExpenseList(),
          ]),
        )
      ],
    );
  }
}
