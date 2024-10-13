import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Helper/Colors.dart';
import '../Helper/Style.dart';

class EngagedStudent extends StatefulWidget {
  const EngagedStudent({super.key});

  @override
  State<EngagedStudent> createState() => _EngagedStudentState();
}

class _EngagedStudentState extends State<EngagedStudent> {
  late int facId;
  late String facDesignation;
  @override
  void initState() {
    super.initState();
    setState(() {
      facId = Get.arguments['faculty_id'];
      facDesignation = Get.arguments['faculty_designation'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Engage", style: AppbarStyle),
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
