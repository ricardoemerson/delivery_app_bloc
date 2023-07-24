import 'package:flutter/material.dart';

import '../../core/widgets/app_bar_logo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarLogo(),
      body: const Center(
        child: Text(
          'HomePage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
