import 'package:flutter/material.dart';
import 'package:awesome_app/app.dart';
import 'package:awesome_app/environment.dart';
import 'package:awesome_app/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Environment.setFlavor(EnvFlavor.staging);

  await Injection.inject();

  runApp(const Application());
}
