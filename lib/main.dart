import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'injection.dart';
import 'presentation/core/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // need explicit binding before new Firebase call
  await Firebase.initializeApp();
  configureInjection(Environment.prod);
  runApp(AppWidget());
}
