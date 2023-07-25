import 'package:flutter/material.dart';

import 'core/providers/application_providers.dart';
import 'core/theme/app_theme.dart';
import 'pages/home/home_router.dart';
import 'pages/product_detail/product_detail_router.dart';
import 'pages/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Delivery App',
        theme: AppTheme.theme,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => HomeRouter.page,
          '/products/detail': (context) => ProductDetailRouter.page,
        },
      ),
    );
  }
}
