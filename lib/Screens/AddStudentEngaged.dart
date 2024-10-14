import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Helper/Colors.dart';
import '../Helper/Style.dart';

class Addstudentengaged extends StatefulWidget {
  const Addstudentengaged({super.key});

  @override
  State<Addstudentengaged> createState() => _AddstudentengagedState();
}

class _AddstudentengagedState extends State<Addstudentengaged> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student Engage", style: AppbarStyle),
        centerTitle: true,
        backgroundColor: muColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Light1),
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );
  }
}
