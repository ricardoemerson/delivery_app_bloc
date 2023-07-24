import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'pages/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery App',
      theme: AppTheme.theme,
      routes: {
        '/': (context) => const SplashPage(),
      },
    );
  }
}
