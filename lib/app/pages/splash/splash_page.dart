import 'package:flutter/material.dart';

import '../../core/extensions/extensions.dart';
import '../../core/widgets/button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: const Color(0xFF140E0E),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context.screenWidth,
                child: Image.asset(
                  'assets/images/lanche.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: context.percentHeight(.30),
                  ),
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(height: 80),
                  Button(
                    label: 'Acessar',
                    width: context.percentWidth(.6),
                    onPressed: () => Navigator.of(context).pushNamed('/home'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
