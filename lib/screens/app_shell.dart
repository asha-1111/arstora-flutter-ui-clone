import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'saved_screen.dart';
import 'search_screen.dart';

/// Bottom navigation on phones, side rail on wide screens.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  static const _pages = <Widget>[
    HomeScreen(),
    SearchScreen(),
    SavedScreen(),
    ProfileScreen(),
  ];

  static const _items = <(IconData, IconData, String)>[
    (Icons.home_outlined, Icons.home, 'Home'),
    (Icons.search, Icons.search, 'Search'),
    (Icons.push_pin_outlined, Icons.push_pin, 'Saved'),
    (Icons.person_outline, Icons.person, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final wide = constraints.maxWidth >= 720;
      final body = AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: KeyedSubtree(
          key: ValueKey(_index),
          child: _pages[_index],
        ),
      );
      return Scaffold(
        body: wide ? Row(children: [_rail(), Expanded(child: body)]) : body,
        bottomNavigationBar: wide ? null : _bar(),
      );
    });
  }

  Widget _rail() {
    return NavigationRail(
      selectedIndex: _index,
      labelType: NavigationRailLabelType.all,
      onDestinationSelected: (i) => setState(() => _index = i),
      destinations: [
        for (final it in _items)
          NavigationRailDestination(
            icon: Icon(it.$1),
            selectedIcon: Icon(it.$2),
            label: Text(it.$3),
          ),
      ],
    );
  }

  Widget _bar() {
    return NavigationBar(
      selectedIndex: _index,
      onDestinationSelected: (i) => setState(() => _index = i),
      destinations: [
        for (final it in _items)
          NavigationDestination(
            icon: Icon(it.$1),
            selectedIcon: Icon(it.$2),
            label: it.$3,
          ),
      ],
    );
  }
}
