import 'package:flutter/material.dart';
import 'package:ict_faculties/Helper/Components.dart';
import 'package:ict_faculties/Network/API.dart';
class SplashScreen extends StatelessWidget {
   // GetStorage instance
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
