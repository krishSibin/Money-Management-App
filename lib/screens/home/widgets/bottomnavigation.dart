import 'package:flutter/material.dart';

import 'package:money_management_app/screens/home/screen_home.dart';

class MoneyManagementBottomNavigation extends StatelessWidget {
  MoneyManagementBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.bottomnavNotifier,
      builder: (BuildContext context, int newIndex, Widget? child) {
        return BottomNavigationBar(
            currentIndex: newIndex,
            onTap: (index) {
              HomeScreen.bottomnavNotifier.value = index;
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Transcation'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category')
            ]);
      },
    );
  }
}
