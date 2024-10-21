import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ict_faculties/Helper/Components.dart';
import 'package:url_launcher/url_launcher.dart';

import '../API/API.dart';
import '../Controller/LoginController.dart';
import '../Helper/Colors.dart';

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
      body: Column(
        children: [
          Container(
            height: getHeight(context, 0.9),
            width: getWidth(context, 1),
            child: Center(
              child: Image(
                image: AssetImage('assets/images/mu_logo.png'),
                height: getHeight(context, 0.13),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child:Text("Version $CurrentVersion",style: TextStyle(fontSize: getSize(context, 2),fontFamily: "mu_reg"),),
            ),
          )
        ],
      ),
    );
  }
}
