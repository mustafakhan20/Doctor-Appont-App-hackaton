import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docapp/Controllers/Auth/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AdminPanelController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> doctors = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;

  RxInt totalUsers = 0.obs;
  RxInt totalDoctors = 0.obs;
  RxInt totalAppointments = 0.obs;

  setLoading(val) {
    isLoading.value = isLoading.value;
  }

  Future<Map<String, String?>?> getAdminEmailPassword() async {
    try {
      // Retrieve the current admin's user ID
      String? userId = AuthController().getUserId();

      if (userId == null) {
        throw Exception("No admin user is currently logged in.");
      }

      // Fetch the admin's document from Firestore
      DocumentSnapshot adminDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (adminDoc.exists) {
        String email = adminDoc['email'];
        String password =
            adminDoc['password']; // Assumes 'password' field exists
        return {'email': email, 'password': password};
      } else {
        print("Admin document not found");
        return null;
      }
    } catch (e) {
      print("Error fetching admin credentials: $e");
      return null;
    }
  }

  Future<String> addDoctor({
    required String email,
    required String password,
    required String name,
    required String specialty,
  }) async {
    try {
      isLoading.value = true;
      // Retrieve the currently logged-in admin's credentials
      final adminUser = _auth.currentUser;
      final adminCredentials = await getAdminEmailPassword();

      if (adminUser == null || adminCredentials == null) {
        return 'Admin credentials not found. Please log in again.';
      }

      // Create the new doctor account
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Assign role and other details to the new doctor
      final doctorUid = userCredential.user!.uid;
      await _firestore.collection('users').doc(doctorUid).set({
        'name': name,
        'email': email,
        'role': 'doctor',
        'specialty': specialty,
        'uid': doctorUid,
      });

      // Restore the admin session
      await _auth.signOut();
      await _auth.signInWithEmailAndPassword(
        email: adminCredentials['email']!,
        password: adminCredentials['password']!,
      );
      await fetchDoctors();
      isLoading.value = false;

      return 'Doctor account created successfully';
    } catch (e) {
      isLoading.value = false;
      Get.log("Error in addDoctor: $e");
      return 'Failed to create doctor account: $e';
    }
  }

  // Fetch doctors from Firestore
  Future<void> fetchDoctors() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'doctor')
        .get();

    doctors.value =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    totalDoctors.value = doctors.length;
  }

  // Fetch users from Firestore
  Future<void> fetchUsers() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'user')
        .get();

    users.value =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    totalUsers.value = users.length;
  }

  // Fetch appointments statistics
  // Future<void> fetchAppointmentsStats() async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('appointments').get();
  //   totalAppointments.value = snapshot.docs.length;
  // }

  // Delete a doctor
  Future<void> deleteDoctor(String doctorId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(doctorId)
          .delete();
      fetchDoctors();
    } catch (e) {
      print("Error deleting doctor: $e");
    }
  }

  // Delete a user from the users collection
  Future<void> deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      fetchUsers();
    } catch (e) {
      print("Error deleting user: $e");
    }
  }
}
