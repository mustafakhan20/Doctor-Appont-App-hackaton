import 'package:docapp/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarWidget extends StatelessWidget {
  final String title;
  final String message;
  final SnackPosition snackPosition;
  final Color colorText;
  final Color backgroundColor;
  final Color borderColor;
  final Duration duration;

  const SnackBarWidget({
    super.key,
    required this.title,
    required this.message,
    this.snackPosition = SnackPosition.TOP,
    this.colorText = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.duration = const Duration(seconds: 3),
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBar());

    return const SizedBox.shrink();
  }

  void showSnackBar() {
    Get.snackbar(
      title,
      message,
      colorText: colorText,
      titleText: TextWidget(
        text: title,
        color: colorText,
        fontweight: FontWeight.bold,
      ),
      borderColor: borderColor,
      borderWidth: 2,
      backgroundColor: backgroundColor,
      dismissDirection: DismissDirection.horizontal,
      snackPosition: snackPosition,
      duration: duration,
      margin: const EdgeInsets.all(10),
      icon: (title.contains('Error') || message.contains('Failed'))
          ? Icon(
              Icons.error_outline,
              color: colorText,
            )
          : Icon(
              Icons.task_alt_outlined,
              color: colorText,
            ),
    );
  }
}
