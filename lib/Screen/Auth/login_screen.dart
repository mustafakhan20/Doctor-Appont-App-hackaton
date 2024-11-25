import 'package:docapp/Controllers/Auth/auth_controller.dart';
import 'package:docapp/Screen/Admin_Panel/admin_dashboard.dart';
import 'package:docapp/Screen/Doctor_Panel/doctor_dashboard.dart';
import 'package:docapp/Screen/User_Panel/user_dashboard.dart';
import 'package:docapp/Screen/Auth/signup_screen.dart';
import 'package:docapp/Widget/snackbar_widget.dart';
import 'package:docapp/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

var _form = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthController().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    if (res == 'Success') {
      setState(() {
        isLoading = false;
      });
      String? userId = AuthController().getUserId();
      String role = await AuthController().getUserRole(userId!);
      if (role == 'admin') {
        Get.offAll(() => const AdminDashboard());
      } else if (role == 'doctor') {
        Get.offAll(() => const DoctorDashboard());
      } else if (role == 'user') {
        Get.offAll(() => const UserDashBoard());
      } else {
        const SnackBarWidget(title: "Error", message: "Invalid user role.")
            .showSnackBar();
      }
    } else {
      setState(() {
        isLoading = false;
      });
      SnackBarWidget(
        title: 'Error',
        message: res,
      ).showSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _form,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const TextWidget(
                    text: 'Login',
                    fontfamily: 'Roboto',
                    color: Colors.white,
                    fontsize: 40.0,
                    fontweight: FontWeight.w700,
                  ),
                  const TextWidget(
                    text: 'Enter Your Credential To Login',
                    color: Colors.white,
                    fontsize: 18.0,
                    fontstyle: FontStyle.italic,
                    fontweight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        RegExp emailRegex =
                            RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                        if (value!.isEmpty) {
                          return "Enter Email";
                        } else if (!emailRegex.hasMatch(value)) {
                          return "Enter Valid Email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: " Email",
                        labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 30,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7), width: 3),
                            borderRadius: BorderRadius.circular(18)),
                        fillColor: Colors.purple.withOpacity(0.5),
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 22),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: " Password",
                        labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500),
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Colors.white,
                          size: 30,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7), width: 3),
                            borderRadius: BorderRadius.circular(18)),
                        fillColor: Colors.purple.withOpacity(0.5),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: 290,
                      height: 55,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_form.currentState!.validate()) {
                              loginUser();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                )
                              : const TextWidget(
                                  fontfamily: 'Montserrat',
                                  text: 'Login',
                                  fontsize: 25.0,
                                  fontstyle: FontStyle.italic,
                                  fontweight: FontWeight.w700,
                                  color: Colors.white,
                                ))),
                  const SizedBox(
                    height: 25,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const TextWidget(
                        text: 'Forget Password',
                        color: Colors.white,
                        fontsize: 18.0,
                        fontweight: FontWeight.w500,
                        fontstyle: FontStyle.italic,
                      )),
                  const SizedBox(
                    height: 138,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextWidget(
                        text: 'Dont Have An Account ?',
                        color: Colors.white,
                        fontsize: 18.0,
                        fontstyle: FontStyle.italic,
                        fontweight: FontWeight.w500,
                      ),
                      TextButton(
                          onPressed: () {
                            Get.offAll(const SignUpScreen(),
                                transition: Transition.fadeIn);
                          },
                          child: TextWidget(
                            text: 'Sign Up',
                            fontsize: 18.0,
                            fontstyle: FontStyle.italic,
                            fontweight: FontWeight.w700,
                            color: Colors.purple.withOpacity(0.9),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
