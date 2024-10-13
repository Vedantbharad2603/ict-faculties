import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ict_faculties/Helper/Components.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage(); // GetStorage instance

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/mu_logo.png'),
          height: getHeight(context, 0.13),
        ),
      ),
    );
  }
}
