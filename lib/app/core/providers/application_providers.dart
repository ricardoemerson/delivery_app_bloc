import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/auth/auth_repository.dart';
import '../../data/repositories/auth/i_auth_repository.dart';
import '../rest_client/rest_client.dart';

class ApplicationProviders extends StatelessWidget {
  final Widget child;

  const ApplicationProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => RestClient()),
        Provider<IAuthRepository>(create: (context) => AuthRepository(restClient: context.read())),
      ],
      child: child,
    );
  }
}
