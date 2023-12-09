import 'package:app/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final isOrganization = false.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final inviteCodeController = TextEditingController();

  final hidePassword = true.obs;

  final Rx<Widget> optionalFields = Container().obs;

  Future register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    var data = <String, dynamic>{
      "name": nameController.text.trim(),
    };

    await AuthService().register(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    Navigator.maybePop(Get.context!);
    ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text("Успешно регистриран профил")));
  }

  final selectedRegion = 0.obs;

  Future<void> selectRegion() async {
    var region = await showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text("Изберете област"),
        content: SizedBox(
          width: 500,
          height: 350,
          child: ListView(
            shrinkWrap: true,
            children: [
              for (var i = 0; i < 28; i++)
                Obx(
                  () => RadioListTile.adaptive(
                    value: i,
                    groupValue: selectedRegion.value,
                    title: Text("Област $i"),
                    onChanged: (val) => selectedRegion.value = i,
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.maybePop(context),
            child: const Text("Откажи"),
          ),
          TextButton(
            onPressed: () => Navigator.maybePop(context, selectedRegion.value),
            child: const Text("Избери"),
          ),
        ],
      ),
    );
  }
}
