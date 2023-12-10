import 'package:app/app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final hidePassword = true.obs;

  Future login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    await AuthService().login(emailController.text.trim(), passwordController.text.trim());

    Get.back();
    ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text("Successfully login")));
    await HapticFeedback.lightImpact();
  }

  Future forgotPassword() async {
    var forgotFormKey = GlobalKey<FormState>();
    var emailForgotController = TextEditingController(text: emailController.text.trim());

    var email = await showDialog<String>(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text("forgot_password".tr),
        content: Form(
          key: forgotFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "forgot_password_description".tr,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailForgotController,
                decoration: InputDecoration(
                  isCollapsed: false,
                  label: Text("email".tr),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "fill_field".tr;
                  }

                  if (!value.isEmail) return "invalid_email".tr;
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          FilledButton.tonal(
            onPressed: () => Get.back(result: "return"),
            child: Text("cancel".tr),
          ),
          FilledButton(
            onPressed: () {
              if (forgotFormKey.currentState!.validate()) Get.back(result: emailForgotController.text.trim());
            },
            child: Text("submit".tr),
          ),
        ],
      ).animate().scaleXY(
            duration: 500.ms,
            curve: Curves.fastLinearToSlowEaseIn,
          ),
    );

    if (email == "return" || email == null) return;

    await AuthService().forgotPassword(email);

    ScaffoldMessenger.of(Get.context!)
        .showSnackBar(const SnackBar(content: Text("Sent a email to change the passwords")));
  }

  void showError(String message) {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning),
        title: Text(message),
      ),
    );
  }
}
