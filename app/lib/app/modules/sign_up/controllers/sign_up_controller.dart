import 'package:app/app/services/auth_service.dart';
import 'package:app/app/services/geo_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  final RxInt selectedRegion = (-1).obs;

  Future register() async {
    if (!formKey.currentState!.validate() || selectedRegion.value == -1) {
      return;
    }

    var data = <String, dynamic>{
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "region": GeoService.regions.keys.toList()[selectedRegion.value],
    };

    await AuthService().register(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    Navigator.maybePop(Get.context!);
    ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text("Успешно регистриран профил")));
  }

  Future<void> selectRegion() async {
    // sort keys alphabetically
    var regions = GeoService.regions.keys.toList()..sort();

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
              for (var i = 0; i < regions.length; i++)
                Obx(
                  () => RadioListTile.adaptive(
                    value: i,
                    groupValue: selectedRegion.value,
                    title: Text(regions[i]),
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
