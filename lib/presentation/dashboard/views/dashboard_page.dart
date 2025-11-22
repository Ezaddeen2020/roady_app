import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bottom_nav_bar.dart';

class DashboardPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: BottomNavBar(navigationShell: navigationShell),
    );
  }
}
