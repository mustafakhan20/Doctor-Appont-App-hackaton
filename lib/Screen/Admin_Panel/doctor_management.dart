import 'package:docapp/Screen/Admin_Panel/admin_drawer.dart';
import 'package:docapp/Widget/snackbar_widget.dart';
import 'package:docapp/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:docapp/Controllers/Admin/admin_controller.dart';

class DoctorManagementScreen extends StatelessWidget {
  const DoctorManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adminController = Get.put(AdminPanelController());

    adminController.fetchDoctors();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C84FF).withOpacity(0.7),
        title: const TextWidget(
          text: 'Doctor Management',
          color: Colors.white,
          fontfamily: "Montserrat",
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 31),
      ),
      drawer: const AdminDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 15),
          SizedBox(
            height: 55,
            width: 230,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color(0xFF0C84FF),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AddDoctorDialog(),
                );
              },
              child: const TextWidget(
                text: "Add New Doctor",
                fontfamily: "Montserrat",
                color: Colors.white,
                fontsize: 20.0,
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: adminController.doctors.length,
                itemBuilder: (context, index) {
                  final doctor = adminController.doctors[index];
                  return ListTile(
                    title: Text(doctor['name']),
                    subtitle: Text(doctor['specialty']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          adminController.deleteDoctor(doctor['uid']),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddDoctorDialog extends StatelessWidget {
  AddDoctorDialog({super.key});

  final nameController = TextEditingController();
  final specialtyController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final adminController = Get.find<AdminPanelController>();

    return AlertDialog(
      title: const TextWidget(text: "Add Doctor", fontfamily: "Montserrat"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: specialtyController,
            decoration: const InputDecoration(labelText: "Specialty"),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: "Password"),
          ),
        ],
      ),
      actions: [
        Obx(
          () => ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: const Color(0xFF0C84FF),
            ),
            onPressed: () async {
              final name = nameController.text;
              final specialty = specialtyController.text;
              final email = emailController.text;
              final password = passwordController.text;
              RegExp emailRegex =
                  RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

              if (email.isEmpty ||
                  password.isEmpty ||
                  name.isEmpty ||
                  specialty.isEmpty) {
                Get.snackbar("Error", "Please fill all fields.");
                // const SnackBarWidget(
                //         title: "Error", message: "Please fill all fields.")
                //     .showSnackBar();
                return;
              } else if (!emailRegex.hasMatch(email)) {
                const SnackBarWidget(
                        title: 'Error', message: "Enter valid Email")
                    .showSnackBar();
                return;
              }

              String result = await adminController.addDoctor(
                  email: email,
                  password: password,
                  name: name,
                  specialty: specialty);

              if (result == 'Doctor account created successfully') {
                Get.back(); // Close dialog
                Get.snackbar("Success", result);
              } else {
                Get.snackbar("Error", result); // Show the error if any
              }
            },
            child: adminController.isLoading.value
                ? const SizedBox(
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const TextWidget(
                    text: "Add",
                    fontfamily: "Montserrat",
                    color: Colors.white,
                  ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: const Color(0xFF0C84FF),
          ),
          onPressed: () => Get.back(),
          child: const TextWidget(
            text: "Cancel",
            fontfamily: "Montserrat",
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
