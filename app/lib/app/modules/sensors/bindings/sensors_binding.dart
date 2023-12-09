import 'package:get/get.dart';

import '../controllers/sensors_controller.dart';

class SensorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SensorsController>(
      () => SensorsController(),
    );
  }
}
