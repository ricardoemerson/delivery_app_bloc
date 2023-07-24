import 'package:flutter/material.dart';

class AppBarLogo extends AppBar {
  AppBarLogo({
    super.key,
    super.elevation = 1,
  }) : super(
          title: Image.asset(
            'assets/images/logo.png',
            width: 80,
          ),
        );
}
