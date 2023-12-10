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
                "sign_up".tr,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              // expandedTitleScale: ,
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
                decoration: InputDecoration(
                  label: Text("name".tr),
                ),
                controller: controller.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "fill_field".tr;
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
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
              const SizedBox(
                height: 15,
              ),
              Obx(
                () => TextFormField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    label: Text("password".tr),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                  ),
                  obscureText: controller.hidePassword.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "fill_field".tr;
                    }

                    if (value.trim() != controller.confirmPasswordController.text.trim()) {
                      return "passwords_do_not_match".tr;
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
                    label: Text("confirm_password".tr),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                  ),
                  obscureText: controller.hidePassword.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "fill_field".tr;
                    }
                    if (value.trim() != controller.passwordController.text.trim()) {
                      return "passwords_do_not_match".tr;
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FilledButton(onPressed: controller.selectRegion, child: Text("select_region".tr)),
              const SizedBox(
                height: 15,
              ),
              FilledButton.icon(
                onPressed: () => controller.register(),
                icon: const Icon(Icons.app_registration_rounded),
                label: Text("sign_up".tr),
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
