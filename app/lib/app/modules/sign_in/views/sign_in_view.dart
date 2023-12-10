import 'package:app/app/modules/sign_up/views/sign_up_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SignInController());
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign In",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: controller.emailController,
                decoration: const InputDecoration(
                  label: Text("Email"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill in the field".tr;
                  }

                  if (!value.isEmail) return "Invalid Email".tr;
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(
                () => TextFormField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    label: const Text("Password"),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                  ),
                  obscureText: controller.hidePassword.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill in the field".tr;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => controller.forgotPassword(),
                  child: const Text("Forgot Password?"),
                ),
              ),
              FilledButton.icon(
                style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size.fromWidth(200),
                  ),
                ),
                onPressed: () => controller.login(),
                icon: const Icon(Icons.login),
                label: const Text("Sign In"),
              ),
              const SizedBox(
                height: 10,
              ),
              FilledButton.tonalIcon(
                style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size.fromWidth(200),
                  ),
                ),
                onPressed: () => Get.to(() => const SignUpView()),
                icon: const Icon(Icons.app_registration_rounded),
                label: const Text("Create an account"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
