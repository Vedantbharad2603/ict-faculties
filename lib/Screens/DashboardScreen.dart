import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ict_faculties/Helper/Components.dart';
import '../Helper/Colors.dart';
import '../Model/UserDataModel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final box = GetStorage();
  late UserData userData;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> storedData = box.read('userdata');
    print("from dashboard");
    print(storedData);
    userData = UserData.fromJson(storedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await CachedNetworkImage.evictFromCache(
              'https://marwadieducation.edu.in/MEFOnline/handler/getImage.ashx?Id=${userData.facultyId}');
          box.write('loggedin', false);
          box.write('userdata', null);
          Get.offNamed('/login');
        },
        child: Icon(Icons.exit_to_app),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Dashboard",
            style: TextStyle(
                color: Colors.black, fontFamily: "mu_reg", fontSize: 23)),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlackTag(
              context,
              Dark1,
              "${userData.firstName} ${userData.lastName}",
              "Faculty Id: ${userData.facultyId}",
              // "Sem: ${userData.classDetails?.semester}  Class: ${userData.classDetails?.className} - ${userData.classDetails?.batch?.toUpperCase()}",
              CachedNetworkImage(
                imageUrl:
                    'https://marwadieducation.edu.in/MEFOnline/handler/getImage.ashx?Id=${userData.facultyId}',
                placeholder: (context, url) => CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1,
                ),
                fit: BoxFit.cover,
              ),
              true,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  children: [
                    TapIcons(context,"Take Attendance", 15, "attendance.png", 45, "/takeAttendance",{'faculty_id': userData.id}),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            BlackTag(
              context,
              Dark1,
              "Upcoming Event",
              "Engineer's Day Celebration",
              Image.asset(
                "assets/images/arrow_right.png",
                fit: BoxFit.cover,
              ),
              false,
            ),
          ],
        ),
      ),
    );
  }
}
