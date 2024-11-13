import 'package:get/get.dart';
import 'package:ict_faculties/Controllers/splash_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SplashController());
  }

}