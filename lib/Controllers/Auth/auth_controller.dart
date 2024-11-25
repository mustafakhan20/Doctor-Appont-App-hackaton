import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docapp/Controllers/User/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  String? getUserId() {
    return _auth.currentUser?.uid;
  }

  String? getUserEmail() {
    return _auth.currentUser?.email;
  }

  Future<String> getUserRole(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        // Return the role field from the Firestore document
        return userDoc['role'];
      } else {
        throw Exception("User document does not exist");
      }
    } catch (e) {
      throw Exception("Failed to fetch user role: $e");
    }
  }

  // Check if an admin account already exists in Firestore
  Future<bool> checkAdminExists() async {
    final adminDocs = await _firestore
        .collection('users')
        .where('role', isEqualTo: 'admin')
        .get();
    return adminDocs.docs.isNotEmpty; // If admin already exists, return true
  }

  // Create the first admin account, ensuring only one admin is created
  Future<String> createAdminAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = '';
    try {
      // Check if admin already exists
      bool adminExists = await checkAdminExists();

      if (adminExists) {
        return 'Admin account already exists';
      }

      // Proceed to create an admin account
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.updateProfile(displayName: name);
      await credential.user!.reload();

      // Create the admin account in Firestore with 'admin' role
      await _firestore.collection("users").doc(credential.user!.uid).set({
        "name": name,
        "email": email,
        "password": password,
        "uid": credential.user!.uid,
        "role": 'admin', // Assign admin role
        "createdAt": FieldValue.serverTimestamp(),
      });

      res = 'Admin account created successfully';
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  // Sign up a normal user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    String role = 'user',
  }) async {
    String res = '';
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.updateProfile(displayName: name);
      await credential.user!.reload();

      await _firestore.collection("users").doc(credential.user!.uid).set({
        "name": name,
        "email": email,
        "password": password,
        "uid": credential.user!.uid,
        "role": role,
        "createdAt": FieldValue.serverTimestamp(),
      });

      res = 'Success';
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = '';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final UserController userController = Get.find<UserController>();
      await userController.getUserInfo();
      res = 'Success';
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<bool> isDoctor() async {
    final userId = getUserId();
    if (userId != null) {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        return userData?['role'] == 'doctor';
      }
    }
    return false;
  }

  Future<bool> isAdmin() async {
    final userId = getUserId();
    if (userId != null) {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        return userData?['role'] == 'admin';
      }
    }
    return false;
  }

  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
      final UserController userController = Get.find<UserController>();
      userController.clearUserData();
    } catch (e) {
      Get.log(e.toString());
    }
  }
}
