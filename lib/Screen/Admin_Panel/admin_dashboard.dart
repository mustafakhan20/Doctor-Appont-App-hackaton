import 'package:docapp/Screen/Admin_Panel/admin_drawer.dart';
import 'package:docapp/Screen/Admin_Panel/doctor_management.dart';
import 'package:docapp/Screen/Admin_Panel/management_appoint.dart';
import 'package:docapp/Screen/Admin_Panel/user_management.dart';
import 'package:docapp/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C84FF).withOpacity(0.7),
        title: const TextWidget(
          text: 'Admin Dashboard',
          color: Colors.white,
          fontfamily: "Montserrat",
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 31),
      ),
      drawer: const AdminDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: 'Dashboard Overview',
              fontsize: 24.0,
              fontweight: FontWeight.bold,
              fontfamily: "Montserrat",
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard('Doctors', '20', const Color(0xFF0C84FF)),
                  _buildStatCard('Users', '150', Colors.green),
                  _buildStatCard('Appointments', '45', Colors.orange),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xFF0C84FF),
                      ),
                      onPressed: () {
                        Get.off(() => const DoctorManagementScreen());
                      },
                      child: const TextWidget(
                        text: 'Manage Doctors',
                        fontfamily: "Montserrat",
                        color: Colors.white,
                        fontsize: 19.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 55,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.green),
                      onPressed: () {
                        Get.off(() => const UserManagementScreen());
                      },
                      child: const TextWidget(
                        text: 'Manage Users',
                        fontfamily: "Montserrat",
                        color: Colors.white,
                        fontsize: 19.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 55,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        Get.off(() => const ManageAppointScreen());
                      },
                      child: const TextWidget(
                        text: 'Manage Appointments',
                        fontfamily: "Montserrat",
                        color: Colors.white,
                        fontsize: 19.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              text: title,
              fontsize: 18.0,
              color: Colors.white,
              fontfamily: "Montserrat",
            ),
            const SizedBox(height: 10),
            TextWidget(
              text: value,
              fontsize: 24.0,
              fontweight: FontWeight.bold,
              color: Colors.white,
              fontfamily: "Montserrat",
            ),
          ],
        ),
      ),
    );
  }
}
