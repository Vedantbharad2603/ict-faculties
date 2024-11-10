import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController{
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    _navigateAfterSplash();
  }
  _navigateAfterSplash() async {
    await Future.delayed(Duration(seconds: 1));
    bool isLoggedIn = box.read('loggedin') ?? false;
    if (isLoggedIn) {
      Get.offAllNamed("/dashboard");
    } else {
      Get.offAllNamed("/login");
    }
  }
}