import 'package:docapp/Controllers/Admin/admin_controller.dart';
import 'package:docapp/Screen/Admin_Panel/admin_drawer.dart';
import 'package:docapp/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adminController = Get.put(AdminPanelController());
    adminController.fetchUsers();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C84FF).withOpacity(0.7),
        title: const TextWidget(
          text: 'User Management',
          color: Colors.white,
          fontfamily: "Montserrat",
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 31),
      ),
      drawer: const AdminDrawer(),
      body: Obx(
        () => ListView.builder(
          itemCount: adminController.users.length,
          itemBuilder: (context, index) {
            final user = adminController.users[index];
            return ListTile(
              title: TextWidget(text: user['name']),
              subtitle: TextWidget(text: user['email']),
            );
          },
        ),
      ),
    );
  }
}
