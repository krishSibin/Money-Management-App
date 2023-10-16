import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/db_model/category/category_model.dart';
import 'package:money_management_app/screens/AddTransaction/screen_add_transaction.dart';

import 'package:money_management_app/screens/home/screen_home.dart';

import 'db_model/transaction/transaction_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryDataAdapter().typeId)) {
    Hive.registerAdapter(CategoryDataAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionDataAdapter().typeId)) {
    Hive.registerAdapter(TransactionDataAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
        routes: {
          ScreenAddTransaction().routeName: (context) => ScreenAddTransaction(),
        });
  }
}
