import 'package:flutter/material.dart';

import '../../core/helpers/env_helper.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SplashPage'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          EnvHelper.instance.get('BACKEND_BASE_URL'),
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
