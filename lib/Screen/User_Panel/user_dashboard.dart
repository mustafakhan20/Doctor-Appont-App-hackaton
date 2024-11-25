import 'package:docapp/Controllers/Auth/auth_controller.dart';
import 'package:docapp/Controllers/User/user_controller.dart';
import 'package:docapp/Screen/Auth/login_screen.dart';
import 'package:docapp/Widget/doctor_section.dart';
import 'package:docapp/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({super.key});

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  final UserController userController = Get.put(UserController());
  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0C84FF),
          title: const TextWidget(
            text: 'Confirm Logout',
            color: Colors.white,
          ),
          content: const TextWidget(
            text: 'Are you sure you want to log out?',
            color: Colors.white,
          ),
          actions: <Widget>[
            TextButton(
              child: const TextWidget(
                text: 'Cancel',
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const TextWidget(
                text: 'Logout',
                color: Colors.white,
              ),
              onPressed: () {
                AuthController().signOutUser();
                Navigator.of(context).pop();
                Get.offAll(const LoginScreen());
              },
            ),
          ],
        );
      },
    );
  }

  List<String> catNames = [
    'Dental',
    'Heart',
    'Eye',
    'Brain',
    'Ear',
  ];
  List<Icon> catIcons = [
    Icon(
      MdiIcons.toothOutline,
      color: const Color(0xFF0C84FF),
      size: 30,
    ),
    Icon(
      MdiIcons.heartPlus,
      color: const Color(0xFF0C84FF),
      size: 30,
    ),
    Icon(
      MdiIcons.eye,
      color: const Color(0xFF0C84FF),
      size: 30,
    ),
    Icon(
      MdiIcons.brain,
      color: const Color(0xFF0C84FF),
      size: 30,
    ),
    Icon(
      MdiIcons.earHearing,
      color: const Color(0xFF0C84FF),
      size: 30,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFD9E4EE),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF0C84FF).withOpacity(0.8),
                      const Color(0xFF0C84FF),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/doctor1.jpg'),
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(
                              Icons.power_settings_new,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              _showLogoutConfirmationDialog();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => TextWidget(
                          text: 'Hi,${userController.user.value.name}',
                          fontsize: 18.0,
                          fontweight: FontWeight.w500,
                          color: Colors.white,
                          fontfamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 5),
                      const TextWidget(
                        text: 'Your Health Is Our\nFirst Priority',
                        color: Colors.white,
                        fontsize: 21.0,
                        fontweight: FontWeight.w500,
                        fontfamily: 'Roboto',
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 15),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  spreadRadius: 3)
                            ]),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Here...',
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 25,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: TextWidget(
                    text: 'Categories',
                    fontsize: 20.0,
                    fontweight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.7),
                    fontfamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: catNames.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            height: 54,
                            width: 54,
                            decoration: const BoxDecoration(
                                color: Color(0xFFF2F8FF),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      spreadRadius: 2)
                                ]),
                            child: Center(
                              child: catIcons[index],
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextWidget(
                            text: catNames[index],
                            fontsize: 16.0,
                            color: Colors.black.withOpacity(0.7),
                            fontweight: FontWeight.w600,
                          )
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextWidget(
                    text: 'Recommeded Doctors',
                    fontsize: 20.0,
                    fontweight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                const DoctorSection()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
