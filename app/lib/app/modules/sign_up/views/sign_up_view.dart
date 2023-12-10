import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SignUpController());
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar.large(
            forceElevated: innerBoxIsScrolled,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Sign up",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            ),
          ),
        ],
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
                controller: controller.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill in the field".tr;
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  label: Text("Email"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill in the fields";
                  }

                  if (!value.isEmail) return "Invalid Email";
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
                      return "Please fill in the fields";
                    }

                    if (value.trim() != controller.confirmPasswordController.text.trim()) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(
                () => TextFormField(
                  controller: controller.confirmPasswordController,
                  decoration: InputDecoration(
                    label: const Text("Confirm password"),
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
                    if (value.trim() != controller.passwordController.text.trim()) {
                      return "Passwords do not match";
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FilledButton(onPressed: controller.selectRegion, child: const Text("Select Region")),
              const SizedBox(
                height: 15,
              ),
              FilledButton.icon(
                onPressed: () => controller.register(),
                icon: const Icon(Icons.app_registration_rounded),
                label: const Text("Sign Up"),
              ),
              SizedBox(
                height: Get.mediaQuery.viewPadding.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
