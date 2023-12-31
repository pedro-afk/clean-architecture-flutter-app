import 'package:complete_advanced_flutter/app/app.dart';
import 'package:complete_advanced_flutter/app/di.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
