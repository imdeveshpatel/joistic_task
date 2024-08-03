import 'package:flutter/material.dart';
import 'package:joistic_task/core/routing/router.dart';
import 'package:joistic_task/core/routing/routes.dart';
import 'package:joistic_task/view/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
   debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      onGenerateRoute: AppPageRouter.generateRoute,
      initialRoute: Routes.splashScreenRoute,
    );
  }
}
