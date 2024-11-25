import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docapp/Components/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  // For the current logged-in user
  var user =
      UserModel(uid: '', name: '', email: '', profilePictureUrl: '', role: '')
          .obs;

  @override
  void onInit() {
    super.onInit();
    getUserInfo(); // Fetch logged-in user's info
  }

  // Sets the current user
  void setUser(UserModel userModel) {
    user.value = userModel;
  }

  // Fetch current logged-in user's data
  Future<void> getUserInfo() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists && userDoc.data() != null) {
          final data = userDoc.data()!;
          final userModel = UserModel(
            uid: currentUser.uid,
            name: data['name'] ?? '',
            email: data['email'] ?? '',
            profilePictureUrl: data['profilePicUrl'] ?? '',
            role: data['role'] ?? '', // Fetch the role
          );

          setUser(userModel);
        } else {
          Get.log("User document does not exist or is empty");
        }
      } else {
        Get.log("No user is currently signed in.");
      }
    } catch (e) {
      Get.log("Failed to get user info: $e");
    }
  }

  // Clear current user's data
  void clearUserData() {
    user.value = UserModel(
        uid: '', name: '', email: '', profilePictureUrl: '', role: '');
  }
}
