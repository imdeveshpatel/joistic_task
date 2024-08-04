import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistic_task/core/services/auth_service.dart';
import 'package:joistic_task/view/homepage/home_screen.dart';
import 'package:joistic_task/view/login/login_screen.dart';
import 'package:joistic_task/core/constants/image_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final AuthService authService = Get.find<AuthService>();
   final AuthService authService = Get.put(AuthService());

  @override
  void initState() {
    super.initState();
    navigateBasedOnAuthStatus();
  }

  void navigateBasedOnAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    bool loggedIn = await authService.isLoggedIn();

    if (loggedIn) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
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
            // child: const Center(
            //   child: CircularProgressIndicator(),
            // ),
          ),
        ],
      ),
    );
  }
}
