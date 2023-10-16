// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db_model/category/category_model.dart';

ValueNotifier<CategoryType> popUpNotifier = ValueNotifier(CategoryType.income);
Future<void> categoryPopUp(BuildContext context) async {
  final categoryController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(15),
          children: [
            TextFormField(
              controller: categoryController,
              decoration: const InputDecoration(
                hintText: 'Enter category',
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  RadioButton(title: 'income', type: CategoryType.income),
                  RadioButton(title: 'expense', type: CategoryType.expense),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                final _categoryData = CategoryData(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: categoryController.text,
                    type: popUpNotifier.value);
                CategoryDB().insertCategory(_categoryData);
                Navigator.of(ctx).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  String title;
  CategoryType type;
  RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: popUpNotifier,
          builder: (BuildContext context, CategoryType NewValue, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: NewValue,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                popUpNotifier.value = value;
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
