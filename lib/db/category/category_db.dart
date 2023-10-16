// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_app/db_model/category/category_model.dart';

abstract class CategoryDbFunctions {
  Future<List<CategoryData>> getCategory();
  Future<void> insertCategory(CategoryData value);
}

class CategoryDB extends CategoryDbFunctions {
  CategoryDB.internal(); //named constructer

  static CategoryDB instance = CategoryDB.internal();

  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryData>> incomeListNotifier = ValueNotifier([]);
  ValueNotifier<List<CategoryData>> expenseListNotifier = ValueNotifier([]);

  @override
  Future<List<CategoryData>> getCategory() async {
    final CategoryDb = await Hive.openBox<CategoryData>('category_db');
    return CategoryDb.values.toList();
  }

  @override
  Future<void> insertCategory(CategoryData value) async {
    final CategoryDb = await Hive.openBox<CategoryData>('category_db');
    await CategoryDb.put(value.id, value);
    refreshUI();
  }

  Future<void> refreshUI() async {
    incomeListNotifier.value.clear();
    expenseListNotifier.value.clear();
    final _categoryDB = await getCategory();
    Future.forEach(_categoryDB, (CategoryData data) {
      if (data.type == CategoryType.income) {
        incomeListNotifier.value.add(data);
      } else {
        expenseListNotifier.value.add(data);
      }
    });
    incomeListNotifier.notifyListeners();
    expenseListNotifier.notifyListeners();
  }

  Future<void> deleteCategory(CategoryData data) async {
    final Categorydata = await Hive.openBox<CategoryData>('category_db');
    await Categorydata.delete(data.id);
    refreshUI();
  }
}
