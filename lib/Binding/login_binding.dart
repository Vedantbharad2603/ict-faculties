import 'package:get/get.dart';
import 'package:ict_faculties/Controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
