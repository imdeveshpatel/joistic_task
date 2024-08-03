
import 'package:flutter/material.dart';
import 'package:joistic_task/core/routing/routes.dart';
import 'package:joistic_task/view/homepage/home_screen.dart';
import 'package:joistic_task/view/login/login_screen.dart';
import 'package:joistic_task/view/splash/splash_screen.dart';

class AppPageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreenRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case Routes.homePageRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) =>  HomeScreen());
      case Routes.loginPageRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());
      

      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            body: Center(
              child: Text('The Page ${settings.name} does not exists.'),
            ),
          ),
        );
    }
  }
}