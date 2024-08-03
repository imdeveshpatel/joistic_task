import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistic_task/core/constants/image_constant.dart';
import 'package:joistic_task/core/routing/routes.dart';
import 'package:joistic_task/view/homepage/home_screen.dart';
import 'package:joistic_task/view/login/login_screen.dart';
import 'package:joistic_task/view_model/controller/login_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
  
     Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.homePageRoute);
      //   Obx(() {
      //   final AuthService authService = Get.put(AuthService());
      //   return authService.firebaseUser.value != null ? HomeScreen() : const LoginScreen();
      // });
    
     
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