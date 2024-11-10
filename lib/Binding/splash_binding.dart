import 'package:get/get.dart';
import 'package:ict_faculties/Controller/SplashController.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SplashController());
  }

}