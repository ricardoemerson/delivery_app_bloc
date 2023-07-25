import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../rest_client/rest_client.dart';

class ApplicationProviders extends StatelessWidget {
  final Widget child;

  const ApplicationProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => RestClient()),
      ],
      child: child,
    );
  }
}
