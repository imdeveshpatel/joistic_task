import 'package:flutter/material.dart';
import 'package:joistic_task/core/constants/color_constant.dart';
import 'package:joistic_task/core/routing/routes.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors().darkBlue, AppColors().darkBlue.withOpacity(.5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text(
                'Login with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
              onPressed: (){
                  Navigator.pushReplacementNamed(context, Routes.homePageRoute);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _handleSignIn() async {
  //   try {
  //     await _googleSignIn.signIn();
  //   } catch (error) {
  //     print(error);
  //   }
  // }
}
