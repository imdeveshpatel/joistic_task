import 'package:flutter/material.dart';
import 'package:joistic_task/core/constants/image_constant.dart';
import 'package:joistic_task/core/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 2), () {
    //   if (FirebaseAuth.instance.currentUser?.uid == null) {
    //     Navigator.pushReplacementNamed(context, Routes.loginPageRoute);
    //   } else {
    //     Navigator.pushReplacementNamed(context, Routes.homePageRoute);
    //   }
    //   ;
    // });
     Future.delayed(const Duration(seconds: 2), () {
       Navigator.pushReplacementNamed(context, Routes.loginPageRoute);
       print("object called");
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  AppImage.homeScreenPng,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}