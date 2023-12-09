import 'package:app/app/modules/sign_in/views/sign_in_view.dart';
import 'package:app/app/modules/sign_up/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnonContent extends StatelessWidget {
  const AnonContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.login),
          title: const Text("Sign In"),
          onTap: () {
            Get.back();
            Get.to(() => const SignInView());
          },
        ),
        ListTile(
          leading: const Icon(Icons.person_add),
          title: const Text("Sign Up"),
          onTap: () {
            Get.back();
            Get.to(() => const SignUpView());
          },
        ),
      ],
    );
  }
}
