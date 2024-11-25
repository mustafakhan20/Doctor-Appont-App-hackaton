import 'package:docapp/Controllers/Auth/auth_controller.dart';
import 'package:docapp/Screen/Admin_Panel/admin_dashboard.dart';
import 'package:docapp/Screen/Admin_Panel/doctor_management.dart';
import 'package:docapp/Screen/Admin_Panel/management_appoint.dart';
import 'package:docapp/Screen/Admin_Panel/user_management.dart';
import 'package:docapp/Screen/Auth/login_screen.dart';
import 'package:docapp/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  signOut() async {
    await AuthController().signOutUser();
    Get.offAll(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF0C84FF),
            ),
            child: TextWidget(
              text: 'Welcome To\nAdmin Dashboard',
              color: Colors.white,
              fontsize: 24.0,
              fontfamily: 'Montserrat',
              letterSpacing: 3.0,
              fontweight: FontWeight.w700,
            ),
          ),
          ListTile(
            title: const TextWidget(
              text: 'Admin Dashboard',
              fontfamily: "Montserrat",
              fontsize: 19.0,
              fontweight: FontWeight.w700,
            ),
            onTap: () {
              Get.off(() => const AdminDashboard());
            },
          ),
          ListTile(
            title: const TextWidget(
              text: 'Manage Doctors',
              fontfamily: "Montserrat",
              fontsize: 19.0,
              fontweight: FontWeight.w700,
            ),
            onTap: () {
              Get.off(() => const DoctorManagementScreen());
            },
          ),
          ListTile(
            title: const TextWidget(
              text: 'Manage Users',
              fontfamily: "Montserrat",
              fontsize: 19.0,
              fontweight: FontWeight.w700,
            ),
            onTap: () {
              Get.off(() => const UserManagementScreen());
            },
          ),
          ListTile(
            title: const TextWidget(
              text: 'Manage Appointments',
              fontfamily: "Montserrat",
              fontsize: 19.0,
              fontweight: FontWeight.w700,
            ),
            onTap: () {
              Get.off(() => const ManageAppointScreen());
            },
          ),
          ListTile(
            trailing: const Icon(
              Icons.logout_outlined,
              size: 29,
            ),
            title: const TextWidget(
              text: 'Logout',
              fontfamily: "Montserrat",
              fontsize: 19.0,
              fontweight: FontWeight.w700,
            ),
            onTap: () {
              signOut();
            },
          ),
        ],
      ),
    );
  }
}
