import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class ButtomNavigation extends StatelessWidget {
  const ButtomNavigation({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  final int selectedIndex;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    const navbarItems = [
      BottomNavigationBarItem(
        label: 'Home',
        activeIcon: Icon(
          FluentIcons.home_16_filled,
        ),
        icon: Icon(
          FluentIcons.home_16_regular,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Profil',
        activeIcon: Icon(FluentIcons.person_20_filled),
        icon: Icon(
          FluentIcons.person_20_regular,
        ),
      ),
    ];
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onTap,
      items: navbarItems.map((e) => e).toList(),
    );
  }
}
