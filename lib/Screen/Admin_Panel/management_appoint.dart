import 'package:docapp/Controllers/Admin/admin_controller.dart';
import 'package:docapp/Screen/Admin_Panel/admin_drawer.dart';
import 'package:docapp/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageAppointScreen extends StatelessWidget {
  const ManageAppointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adminController = Get.put(AdminPanelController());
    adminController.fetchUsers();
    adminController.fetchDoctors();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C84FF).withOpacity(0.7),
        title: const TextWidget(
          text: 'Manage Appointments',
          color: Colors.white,
          fontfamily: "Montserrat",
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 31),
      ),
      drawer: const AdminDrawer(),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Users: ${adminController.totalUsers.value}"),
              Text("Total Doctors: ${adminController.totalDoctors.value}"),
              // ignore: prefer_const_constructors
              Text("Total Appointments: 000"),
            ],
          ),
        ),
      ),
    );
  }
}
