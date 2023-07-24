import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../rest_client/rest_client.dart';

class ApplicationProviders extends StatelessWidget {
  final Widget child;

  const ApplicationProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => RestClient()),
      ],
      child: child,
    );
  }
}
