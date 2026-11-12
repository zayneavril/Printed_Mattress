import 'package:first_app/widgets/app_title.dart';
import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentIndex: 5, // Settings tab
      appBar: AppBar(title: const AppTitle('Settings')),
      child: const Center(
        child: Text(
          "Settings Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
