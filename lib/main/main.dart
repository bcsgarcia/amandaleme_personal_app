import 'package:flutter/material.dart';

import '../app/view/app.dart';

import 'factories/factories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App(
    authenticationRepository: makeAuthenticationRepositoryFactory(),
  ));
}
