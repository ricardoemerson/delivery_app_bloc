import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_cubit.dart';
import 'login_page.dart';

class LoginRouter {
  LoginRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => LoginCubit(),
          ),
        ],
        child: const LoginPage(),
      );
}
