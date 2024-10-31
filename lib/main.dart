import 'package:flutter/material.dart';
import 'package:jeitaly_signaturegenerator_flutter/interface/screen/home_screen.dart';
import 'package:jeitaly_signaturegenerator_flutter/references.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: References.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: References.primaryColor,
          primary: References.primaryColor,
        ),
        useMaterial3: true,
      ),
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route: (final BuildContext context) => HomeScreen(),
      },
    );
  }
}
