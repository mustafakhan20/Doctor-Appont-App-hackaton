import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docapp/Controllers/User/user_controller.dart';
import 'package:docapp/Screen/Admin_Panel/admin_dashboard.dart';
import 'package:docapp/Screen/Doctor_Panel/doctor_dashboard.dart';
import 'package:docapp/Screen/User_Panel/user_dashboard.dart';
import 'package:docapp/Screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            // Check the user's role and navigate based on it
            return FutureBuilder<String>(
              future: getUserRole(snapshot.data!.uid),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (roleSnapshot.hasError) {
                  return const Center(child: Text("Error loading user role"));
                } else {
                  final role = roleSnapshot.data!;
                  if (role == 'admin') {
                    return const AdminDashboard();
                  } else if (role == 'doctor') {
                    return const DoctorDashboard();
                  } else {
                    return const UserDashBoard();
                  }
                }
              },
            );
          } else {
            // If no user is logged in, show the Welcome Screen
            return const WelcomeScreen();
          }
        },
      ),
    );
  }

  /// Fetches the role of the user from Firestore
  Future<String> getUserRole(String userId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (!userDoc.exists) {
      throw StateError("User document does not exist");
    }

    final role = userDoc['role'];
    return role;
  }
}
