import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ict_faculties/Controllers/student_engaged_controller.dart';
import 'package:ict_faculties/Helper/colors.dart';
import 'package:ict_faculties/Helper/Style.dart';
import 'package:ict_faculties/Models/engage_student.dart';
import 'package:ict_faculties/Screens/Exception/data_not_found.dart';
import 'package:ict_faculties/Screens/Exception/no_students_available.dart';
import 'package:ict_faculties/Screens/Loading/adaptive_loading_screen.dart';
import 'package:intl/intl.dart';

class EngagedStudentScreen extends StatefulWidget {
  const EngagedStudentScreen({super.key});

  @override
  State<EngagedStudentScreen> createState() => _EngagedStudentScreenState();
}

class _EngagedStudentScreenState extends State<EngagedStudentScreen>
    with SingleTickerProviderStateMixin {
  late int facId;
  late String facDesignation;
  bool isLoading = false;
  List<EngagedStudent>? engagedStudentsDataList;
  List<EngagedStudent>? filteredStudentsDataList;
  final StudentController studentController = Get.put(StudentController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    facId = Get.arguments['faculty_id'];
    facDesignation = Get.arguments['faculty_des'];
    _tabController = TabController(
      length: isHOD() ? 4 : 3,
      vsync: this,
    );
    fetchEngagedStudentDetail();
  }

  Future<void> fetchEngagedStudentDetail() async {
    setState(() {
      isLoading = true;
    });

    // Fetch the data
    List<EngagedStudent>? fetchedData = await studentController.getEngageStudentsByCC(facId);
    if (!mounted) return;

    setState(() {
      engagedStudentsDataList = fetchedData;
      filteredStudentsDataList = List.from(engagedStudentsDataList ?? []);
      isLoading = false;
    });
  }

  bool isHOD() => facDesignation.toLowerCase() == "hod";

  List<EngagedStudent> filterStudents(String filter) {
    if (filter == "ALL") {
      return List.from(engagedStudentsDataList ?? []);
    } else if (filter == "CURRENT") {
      return engagedStudentsDataList?.where((student) {
        return student.endDate != null &&
            (student.endDate!.isAfter(DateTime.now()) ||
                student.endDate!.isAtSameMomentAs(DateTime.now()));
      }).toList() ?? [];
    } else if (filter == "PAST") {
      return engagedStudentsDataList?.where((student) {
        return student.endDate != null && student.endDate!.isBefore(DateTime.now());
      }).toList() ?? [];
    } else if (filter == "BY ME") {
      return engagedStudentsDataList?.where((student) {
        return student.facultyInfoId == facId;
      }).toList() ?? [];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Student Engage", style: AppbarStyle),
        centerTitle: true,
        backgroundColor: muColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Light1),
          onPressed: () {
            Get.offAllNamed("/dashboard");
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          dividerColor: muColor,
          labelColor: backgroundColor,
          labelStyle: TextStyle(fontFamily: 'mu_reg',fontSize: 20,fontWeight: FontWeight.bold),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 5,
          unselectedLabelColor: Colors.black45,
          unselectedLabelStyle: TextStyle(fontFamily: 'mu_reg',fontSize: 15,fontWeight: FontWeight.bold),
          tabs: isHOD()
              ? [
            Tab(text: "ALL",),
            Tab(text: "CURRENT",),
            Tab(text: "PAST",),
            Tab(text: "BY ME",),
          ]
              : [
            Tab(text: "ALL",),
            Tab(text: "CURRENT",),
            Tab(text: "PAST",),
          ],
          indicatorColor: Colors.white,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: muColor,
        child: Icon(Icons.person_add_alt_1_rounded, color: muGrey),
        onPressed: () => Get.toNamed("/addEngagedStudent",
            arguments: {'faculty_id': facId, 'faculty_des': facDesignation}),
      ),
      body: isLoading
          ? AdaptiveLoadingScreen()
          : TabBarView(
        controller: _tabController,
        children: isHOD()
            ? [
          buildStudentList(filterStudents("ALL")),
          buildStudentList(filterStudents("CURRENT")),
          buildStudentList(filterStudents("PAST")),
          buildStudentList(filterStudents("BY ME")),
        ]
            : [
          buildStudentList(filterStudents("ALL")),
          buildStudentList(filterStudents("CURRENT")),
          buildStudentList(filterStudents("PAST")),
        ],
      ),
    );
  }

  Widget buildStudentList(List<EngagedStudent> students) {
    return RefreshIndicator.adaptive(
      color: muColor,
      backgroundColor: backgroundColor,
      onRefresh: fetchEngagedStudentDetail,
      child: students.isEmpty
          ? DataNotFound()
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          var student = students[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: muGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Student Name: ${student.studentName}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Enrollment No: ${student.enrollmentNo}",
                    style: TextStyle(fontSize: 14)),
                SizedBox(height: 8),
                Text("Granted by: ${student.facultyName}",
                    style: TextStyle(fontSize: 14)),
                SizedBox(height: 8),
                Text("Engaged Type: ${student.type == "oe" ? "Officially Engaged" : "Granted Leave"}",
                    style: TextStyle(fontSize: 14)),
                SizedBox(height: 8),
                Text("Reason: ${student.reason ?? 'N/A'}",
                    style: TextStyle(fontSize: 14)),
                SizedBox(height: 8),
                Text("Start Date: ${student.startDate != null ? DateFormat('yyyy-MM-dd').format(student.startDate!) : 'N/A'}",
                    style: TextStyle(fontSize: 14)),
                SizedBox(height: 8),
                Text("End Date: ${student.endDate != null ? DateFormat('yyyy-MM-dd').format(student.endDate!) : 'N/A'}",
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          );
        },
      ),
    );
  }
}
