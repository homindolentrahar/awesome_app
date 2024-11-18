import 'package:awesome_app/core/initializer.dart';
import 'package:flutter/material.dart';
import 'package:awesome_app/app.dart';
import 'package:awesome_app/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Injection.inject();
  await Initializer.init();

  runApp(const Application());
}
