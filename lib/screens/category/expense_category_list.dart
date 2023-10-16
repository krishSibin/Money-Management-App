import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db_model/category/category_model.dart';
//import 'package:money_management_app/db/category/category_db.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB.instance.expenseListNotifier,
      builder:
          (BuildContext context, List<CategoryData> newCategory, Widget? _) {
        return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final _categoryData = newCategory[index];
              return ListTile(
                title: Text(_categoryData.name),
                trailing: IconButton(
                    onPressed: () {
                      CategoryDB.instance.deleteCategory(_categoryData);
                    },
                    icon: Icon(Icons.delete)),
              );
            },
            separatorBuilder: (context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newCategory.length);
      },
    );
  }
}
