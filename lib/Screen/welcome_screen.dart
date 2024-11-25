import 'package:docapp/Screen/Auth/signup_screen.dart';
import 'package:docapp/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            const Color(0xFF0C84FF).withOpacity(0.8),
            const Color(0xFF0C84FF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(20)),
            Image.asset('assets/images/doctors.png'),
            const SizedBox(height: 40),
            const TextWidget(
              text: 'Doctors Online',
              color: Colors.white,
              fontsize: 35.0,
              fontweight: FontWeight.bold,
              letterSpacing: 1.0,
              wordSpacing: 2.0,
              fontfamily: 'Montserrat',
            ),
            const SizedBox(height: 10),
            const TextWidget(
              text: 'Appoint Your Doctor',
              color: Colors.white,
              fontsize: 18.0,
              fontweight: FontWeight.w500,
              fontfamily: 'Montserrat',
            ),
            const SizedBox(height: 40),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Get.offAll(() => const SignUpScreen(),
                      transition: Transition.fadeIn);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  child: const TextWidget(
                    text: "Let's Go",
                    color: Color(0xFF0C84FF),
                    fontsize: 20.0,
                    fontweight: FontWeight.bold,
                    fontfamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Image.asset(
              'assets/images/lined heart.png',
              color: Colors.white,
              scale: 2.5,
            ),
          ],
        ),
      ),
    );
  }
}
