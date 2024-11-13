import 'dart:convert';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ict_faculties/Controllers/login_controller.dart';
import 'package:ict_faculties/Helper/Components.dart';
import 'package:ict_faculties/Models/faculty.dart';
import 'package:ict_faculties/Network/API.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Helper/Colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final box = GetStorage();
  late Faculty userData;
  LoginController loginControl = Get.put(LoginController());

  @override
  void initState() {
    _checkUpdated();
    super.initState();
    Map<String, dynamic> storedData = box.read('userdata');
    print("from dashboard");
    print(storedData);
    userData = Faculty.fromJson(storedData);
  }

  _getDesignation() {
    if(userData.designation=='tp'){
      return "Trainee Professor";
    }
    else if(userData.designation == 'ap'){
      return "Assistant Professor";
    }
    else if(userData.designation == 'hod'){
      return "HOD";
    }
    else if(userData.designation == 'la'){
      return "Lab Assistant";
    }
    else{
      return userData.designation;
    }
  }

  _checkUpdated() async {

    if(!await loginControl.checkVersion('faculty',CurrentVersion))
    {
      ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs:
        ArtDialogArgs(
          type: ArtSweetAlertType.warning,
          sizeSuccessIcon: 70,
          confirmButtonText: "Update Now", // Hides the confirm button
          confirmButtonColor: muColor,
          onConfirm: () async {
            String url = 'https://devanpatel28.blogspot.com/';
            await launch(url);
          },
          title: "App update available!",
          dialogDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await CachedNetworkImage.evictFromCache(facultyImageAPI(userData.facultyId));
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
      body: SingleChildScrollView(  // Allows the entire screen to scroll
        child: Column(
          children: [
            // BlackTag Widget for Faculty Information
            BlackTag(
              context,
              Dark1,
              "${userData.firstName} ${userData.lastName}",
              "ID: ${userData.facultyId}  -  ${_getDesignation()}",
              CachedNetworkImage(
                imageUrl: facultyImageAPI(userData.facultyId),
                placeholder: (context, url) =>  Stack(
                  children: [Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.black45,
                  ),]
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.black87,
                ),
                fit: BoxFit.cover,
              ),
              false,
            ),
            SizedBox(height: 20),

            // Container for GridView inside SingleChildScrollView
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 400,  // Adjust this height based on your needs
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: GridView.count(
                  shrinkWrap: true,  // Ensures the GridView takes only as much space as it needs
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.9,
                  padding: EdgeInsets.all(10), // Padding for the GridView
                  children: [
                    TapIcons(context, "Attendance", 2, "attendance.png", 45, "/takeAttendance", {'faculty_id': userData.id}),
                    TapIcons(context, "Student Engaged", 2, "attendance.png", 45, "/engagedStudent", {'faculty_id': userData.id,'faculty_des':userData.designation}),
                    TapIcons(context, "Extra Attendance", 2, "attendance.png", 45, "/takeExtraAttendance", {'faculty_id': userData.id,'faculty_des':userData.designation}),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
