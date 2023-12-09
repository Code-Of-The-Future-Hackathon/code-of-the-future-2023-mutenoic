import 'package:app/app/services/auth_service.dart';
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

  final Map<String, LatLng> regions = {
    "Видин": const LatLng(43.9796788, 22.8361745),
    "Монтана": const LatLng(43.4142573, 23.1862031),
    "Враца": const LatLng(43.2074399, 23.5081144),
    "Плевен": const LatLng(43.4212324, 24.5733336),
    "Ловеч": const LatLng(43.1445293, 24.669845),
    "Велико Търново": const LatLng(43.0840923, 25.4772306),
    "Габрово": const LatLng(42.8490305, 25.2428752),
    "Русе": const LatLng(43.8217113, 25.8773911),
    "Тарговище": const LatLng(43.2566209, 26.4854426),
    "Разград": const LatLng(43.5297294, 26.5085427),
    "Силистра": const LatLng(44.1112406, 27.234157),
    "Добрич": const LatLng(43.5752939, 27.6560285),
    "Варна": const LatLng(43.2049731, 27.7780994),
    "Шумен": const LatLng(43.2697708, 26.8180391),
    "Перник": const LatLng(42.5963485, 23.010248),
    "Кюстендил": const LatLng(42.2867362, 22.6727961),
    "София-град": const LatLng(42.6545373, 23.0353193),
    "Пазарджик": const LatLng(42.1887991, 24.2524007),
    "Пловдив": const LatLng(42.1442187, 24.6584732),
    "Стара Загора": const LatLng(42.4193111, 25.5836621),
    "Сливен": const LatLng(42.6654771, 26.2426619),
    "Ямбол": const LatLng(42.4771955, 26.46175),
    "Бургас": const LatLng(42.5061, 27.4678),
    "Благоевград": const LatLng(42.0138205, 23.0168014),
    "Смолян": const LatLng(41.5791427, 24.6999554),
    "Кърджали": const LatLng(41.6288288, 25.3414993),
    "Хасково": const LatLng(41.9328333, 25.5074588),
  };

  Future<void> selectRegion() async {
    // sort keys alphabetically
    var regions = this.regions.keys.toList()..sort();

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
