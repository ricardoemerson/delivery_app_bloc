import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'register_cubit.dart';
import 'register_page.dart';

class RegisterRouter {
  RegisterRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => RegisterCubit(authRepository: context.read()),
          ),
        ],
        child: const RegisterPage(),
      );
}
