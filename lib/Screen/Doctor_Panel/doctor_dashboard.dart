import 'package:docapp/Controllers/Auth/auth_controller.dart';
import 'package:docapp/Screen/Auth/login_screen.dart';
import 'package:docapp/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  signOut() async {
    await AuthController().signOutUser();
    Get.offAll(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Dashboard'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome to the Doctor Dashboard'),
            ElevatedButton(
                onPressed: () {
                  signOut();
                },
                child: TextWidget(text: "Log Out"))
          ],
        ),
      ),
    );
  }
}
