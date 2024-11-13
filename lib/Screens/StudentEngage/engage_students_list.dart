import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ict_faculties/Controllers/student_controller.dart';
import 'package:ict_faculties/Helper/Colors.dart';
import 'package:ict_faculties/Helper/Components.dart';
import 'package:ict_faculties/Helper/Style.dart';
import 'package:ict_faculties/Models/engage_student.dart';
import 'package:ict_faculties/Screens/Loading/mu_loading_screen.dart';
import 'package:intl/intl.dart'; // To format dates

class EngagedStudentScreen extends StatefulWidget {
  const EngagedStudentScreen({super.key});

  @override
  State<EngagedStudentScreen> createState() => _EngagedStudentScreenState();
}

class _EngagedStudentScreenState extends State<EngagedStudentScreen> {
  late int facId;
  late String facDesignation;
  bool isLoading = false;
  List<EngagedStudent>? engagedStudentsDataList;
  List<EngagedStudent>? filteredStudentsDataList;
  final StudentController studentController = Get.put(StudentController());
  String selectedFilter = "ALL"; // Default selected filter

  @override
  void initState() {
    super.initState();
    setState(() {
      facId = Get.arguments['faculty_id'];
      facDesignation = Get.arguments['faculty_des'];
    });
    fetchEngagedStudentDetail();
  }

  Future<void> fetchEngagedStudentDetail() async {
    setState(() {
      isLoading = true;
    });

    // Fetch the data and map it to List<EngagedStudent>
    List<EngagedStudent>? fetchedData = await studentController.getEngageStudentsByCC(facId);
    if (!mounted) return;

    setState(() {
      engagedStudentsDataList = fetchedData;
      filteredStudentsDataList = List.from(engagedStudentsDataList!); // Initially show all students
      isLoading = false;
    });
  }

  void filterStudents(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == "ALL") {
        filteredStudentsDataList = List.from(engagedStudentsDataList!);
      } else if (filter == "CURRENT") {
        filteredStudentsDataList = engagedStudentsDataList!.where((student) {
          return student.endDate != null &&
              (student.endDate!.isAfter(DateTime.now()) || student.endDate!.isAtSameMomentAs(DateTime.now()));
        }).toList();
      } else if (filter == "PAST") {
        filteredStudentsDataList = engagedStudentsDataList!.where((student) {
          return student.endDate != null && student.endDate!.isBefore(DateTime.now());
        }).toList();
      } else if (filter == "BY ME") {
        filteredStudentsDataList = engagedStudentsDataList!.where((student) {
          return student.facultyInfoId == facId;
        }).toList();
      }
    });
  }

  bool isHOD() => facDesignation.toLowerCase() == "hod";

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: muColor,
        child: Icon(Icons.person_add_alt_1_rounded, color: muGrey),
        onPressed: () => Get.toNamed("/addEngagedStudent",
            arguments: {'faculty_id': facId, 'faculty_des': facDesignation}),
      ),
      body: isLoading
          ? Center(child: LoadingScreen())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chips for filtering
          Container(
            height: getHeight(context, 0.07),
            width: double.infinity,
            child: isHOD()
                ? Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildChip("ALL"),
                      _buildChip("CURRENT"),
                      _buildChip("PAST"),
                      _buildChip("BY ME"),
                    ],
                  ),
                ),
              ),
            )
                : Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: getWidth(context, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildChip("ALL"),
                      _buildChip("CURRENT"),
                      _buildChip("PAST"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(indent: 10, endIndent: 10),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudentsDataList?.length ?? 0,
              itemBuilder: (context, index) {
                var student = filteredStudentsDataList![index];

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
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
          ),
        ],
      ),
    );
  }

  // Helper method to build chips
  Widget _buildChip(String label) {
    return ChoiceChip(
      elevation: 5,
      label: Container(
        width: getWidth(context, isHOD() ? 0.15 : 0.2),
        height: getHeight(context, 0.03),
        child: Align(alignment: Alignment.center, child: Text(label)),
      ),
      selected: selectedFilter == label,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            filterStudents(label);
          });
        }
      },
      side: BorderSide.none,
      selectedColor: muColor,
      showCheckmark: false,
      labelStyle: TextStyle(
          fontFamily: 'mu_bold',
          fontSize: getSize(context, isHOD() ? 1.7 : 2),
          color: selectedFilter == label ? Colors.white : Colors.black),
      backgroundColor: Colors.grey[200],
    );
  }
}
