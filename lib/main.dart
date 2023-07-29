import 'package:flutter/material.dart';

import 'app/app_widget.dart';
import 'app/core/helpers/env_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EnvHelper.instance.load();

  runApp(AppWidget());
}
