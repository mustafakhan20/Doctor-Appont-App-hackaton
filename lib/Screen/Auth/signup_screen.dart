import 'package:docapp/Controllers/Auth/auth_controller.dart';
import 'package:docapp/Screen/Auth/login_screen.dart';
import 'package:docapp/Widget/snackbar_widget.dart';
import 'package:docapp/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = true;
  bool isLoading = false;

  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthController().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );
    if (res == 'Success') {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      AuthController().signOutUser();
      const SnackBarWidget(
              title: 'Success',
              message: ' Account created successfully!\nPlease Login Here')
          .showSnackBar();
      Get.offAll(const LoginScreen());
    } else {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

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
        color: Colors.blue,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              const Center(
                  child: TextWidget(
                text: 'Sign Up',
                color: Colors.white,
                fontfamily: 'Roboto',
                fontsize: 35.0,
                fontstyle: FontStyle.italic,
                fontweight: FontWeight.w700,
              )),
              const SizedBox(
                height: 15,
              ),
              const TextWidget(
                text: 'Create Your Account',
                color: Colors.white,
                fontsize: 18.0,
                fontstyle: FontStyle.italic,
                fontweight: FontWeight.w500,
              ),
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12, top: 27),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: " Name",
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                    prefixIcon: const Icon(
                      Icons.person,
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
                margin: const EdgeInsets.only(left: 12, right: 12, top: 27),
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
                margin: const EdgeInsets.only(left: 12, right: 12, top: 27),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: showPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters long";
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return "Password must contain at least one uppercase letter";
                    }
                    if (!value.contains(RegExp(r'[a-z]'))) {
                      return "Password must contain at least one lowercase letter";
                    }
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return "Password must contain at least one numeric character";
                    }
                    if (!value.contains(RegExp(r'[!@#\$%^&*()<>?/|}{~:]'))) {
                      return "Password must contain at least one special character";
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
                    suffixIcon: GestureDetector(
                      onTap: () {
                        showPassword = !showPassword;
                        setState(() {});
                      },
                      child: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                        size: 30,
                      ),
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
                height: 27,
              ),
              SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_form.currentState!.validate()) {
                          signUpUser();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.withOpacity(0.5)),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            )
                          : const TextWidget(
                              text: 'Sign Up',
                              fontfamily: 'Montserrat',
                              fontsize: 25.0,
                              fontstyle: FontStyle.italic,
                              fontweight: FontWeight.w700,
                              color: Colors.white,
                            ))),
              const SizedBox(
                height: 30,
              ),
              const TextWidget(
                text: 'Or',
                color: Colors.white,
                fontsize: 20.0,
                fontstyle: FontStyle.italic,
                fontweight: FontWeight.w500,
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 35.0,
                        width: 35.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/google.logo.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      const TextWidget(
                        text: 'Sign In With Google',
                        color: Colors.white,
                        fontsize: 20.0,
                        fontstyle: FontStyle.italic,
                        fontweight: FontWeight.w500,
                      )
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextWidget(
                    text: 'Already Have An Account ?',
                    color: Colors.white,
                    fontsize: 18.0,
                    fontstyle: FontStyle.italic,
                    fontweight: FontWeight.w500,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.offAll(const LoginScreen(),
                            transition: Transition.fadeIn);
                      },
                      child: TextWidget(
                        text: 'Login',
                        color: Colors.purple.withOpacity(0.9),
                        fontsize: 18.0,
                        fontstyle: FontStyle.italic,
                        fontweight: FontWeight.w700,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    )));
  }
}
