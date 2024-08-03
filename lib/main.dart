import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistic_task/core/routing/router.dart';
import 'package:joistic_task/core/routing/routes.dart';
import 'package:joistic_task/view/login/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
