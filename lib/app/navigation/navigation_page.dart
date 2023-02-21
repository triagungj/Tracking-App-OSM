import 'package:flutter/material.dart';
import 'package:mobile_app/app/home/home_page.dart';
import 'package:mobile_app/app/navigation/bottom_navigation.dart';
import 'package:mobile_app/app/profile/profile_page.dart';
import 'package:mobile_app/services/local_service.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final _selectedIndex = ValueNotifier<int>(0);
  bool isDriver = false;

  Future<void> getAccountPrevilege() async {
    final isDriverAccount = await LocalService().isDriverAccount() ?? false;
    if (isDriverAccount) {
      setState(() {
        isDriver = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAccountPrevilege();
  }

  @override
  Widget build(BuildContext context) {
    const widgetItems = [
      HomePage(),
      ProfilePage(),
    ];

    const widgetItemsDriver = [
      HomePage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, value, widget) {
          return IndexedStack(
            index: _selectedIndex.value,
            children: isDriver
                ? widgetItemsDriver.map((e) => e).toList()
                : widgetItems.map((e) => e).toList(),
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, value, widget) {
          return ButtomNavigation(
            selectedIndex: value,
            onTap: (index) {
              _selectedIndex.value = index;
            },
          );
        },
      ),
    );
  }
}
