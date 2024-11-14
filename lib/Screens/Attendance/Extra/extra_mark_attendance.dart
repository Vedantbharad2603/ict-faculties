import 'dart:ui';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ict_faculties/Models/extra_attendance_list.dart';
import 'package:ict_faculties/Models/extra_attendance_schedule.dart';
import 'package:ict_faculties/Models/extra_mark_attendance_data.dart';
import 'package:ict_faculties/Network/API.dart';
import 'package:ict_faculties/Controllers/attendance_controller.dart';
import 'package:ict_faculties/Helper/Colors.dart';
import 'package:ict_faculties/Helper/Components.dart';
import 'package:ict_faculties/Helper/Style.dart';
import 'package:ict_faculties/Screens/Loading/mu_loading_screen.dart';
import 'package:intl/intl.dart';

class MarkExtraAttendance extends StatefulWidget {
  const MarkExtraAttendance({super.key});

  @override
  State<MarkExtraAttendance> createState() => _MarkExtraAttendanceState();
}

class _MarkExtraAttendanceState extends State<MarkExtraAttendance> {
  final AttendanceController attendanceController =
  Get.put(AttendanceController());
  List<ExtraAttendanceList>? extraAttendanceDataList;
  List<ExtraAttendanceList>? extraAttendanceDataCopyList;
  List<ExtraMarkAttendanceData> uploadExtraAttendanceDataList =[];

  bool isLoading = false;
  bool isUploading = false;
  bool isSelectAll = true;
  late DateTime selectedDate;
  late int facultyId;
  late int subjectId;
  ExtraSchedule? scheduleData;

  @override
  void initState() {
    super.initState();
    setState(() {
      subjectId = Get.arguments['subject_id'];
      selectedDate = Get.arguments['selected_date'];
      facultyId = Get.arguments['faculty_id'];
      scheduleData = Get.arguments['schedule'];
      // print("$subjectId + $facultyId + $selectedDate");
    });
    fetchAttendanceList();
  }

  Future<void> fetchAttendanceList() async {
    setState(() {
      isLoading = true;
    });
    String formatedSelectedDate = DateFormat("yyyy-MM-dd").format(selectedDate);
    List<ExtraAttendanceList>? fetchedExtraAttendanceDataList =
    await attendanceController.getExtraAttendanceList(
        subjectId,
        facultyId,
        formatedSelectedDate);
    if (!mounted) return;
    setState(() {
      extraAttendanceDataList = fetchedExtraAttendanceDataList;
      isLoading = false;
    });
    createAttendanceCopy();
  }

  Future<void> createAttendanceCopy() async {
    extraAttendanceDataCopyList = extraAttendanceDataList?.map((attendance) {
      ExtraAttendanceList copiedAttendance = attendance.copyWith();
      return copiedAttendance;
    }).toList();
  }

  Future<void> uploadExtraAttendance() async {
    setState(() {
      isUploading = true;
    });

    // Loop through each student and add only modified records to the list
    for (int i = 0; i < extraAttendanceDataCopyList!.length; i++) {
      if (extraAttendanceDataList![i].count != extraAttendanceDataCopyList![i].count) {
        uploadExtraAttendanceDataList.add(ExtraMarkAttendanceData(
          subjectId: subjectId,
          facultyId: facultyId,
          studentId: extraAttendanceDataCopyList![i].studentID,
          date: DateFormat("yyyy-MM-dd").format(selectedDate),
          count: extraAttendanceDataCopyList![i].count,
        ));
      }
    }
    print("------------------------------------------------\n ExtraAttendanceDataList = ");
    for (var item in extraAttendanceDataList!) {
      print(item.toString());
    }
    print("------------------------------------------------\n ExtraExtraAttendanceDataCopyList = ");
    for (var item in extraAttendanceDataCopyList!) {
      print(item.toString());
    }
    // Print to verify the data being uploaded
    print("------------------------------------------------\n Upload Time = ");
    for (var item in uploadExtraAttendanceDataList) {
      print(item.toString());
    }

    // Check if there is any data to upload
    if (uploadExtraAttendanceDataList.isNotEmpty) {
      bool success = await attendanceController.uploadExtraAttendance(uploadExtraAttendanceDataList);

      // Show success or error alert based on the result
      if (success) {
        ArtSweetAlert.show(
          context: context,
          barrierDismissible: false,
          artDialogArgs: ArtDialogArgs(
            dialogPadding: EdgeInsets.only(top: 30),
            type: ArtSweetAlertType.success,
            sizeSuccessIcon: 70,
            confirmButtonText: "",
            confirmButtonColor: Colors.white,
            title: "Attendance Uploaded!",
            dialogDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          Get.back();
          Get.back();
        });
      } else {
        // Handle failure
        ArtSweetAlert.show(
          context: context,
          barrierDismissible: false,
          artDialogArgs: ArtDialogArgs(
            dialogPadding: EdgeInsets.only(top: 30),
            type: ArtSweetAlertType.danger,
            sizeSuccessIcon: 70,
            confirmButtonText: "",
            confirmButtonColor: Colors.white,
            title: "Error uploading attendance!",
            dialogDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        );
        Future.delayed(const Duration(milliseconds: 1500), () {
          Get.back();
        });
      }
    } else {
      // No data to upload, show a message if needed
      print("No modified records to upload.");
    }

    setState(() {
      isUploading = false;
    });
  }



  void showStudentDetails(ExtraAttendanceList attendanceList) {
    Get.defaultDialog(
      title: "Student Details",
      titleStyle:
      TextStyle(fontFamily: 'mu_bold', fontSize: getSize(context, 2.5)),
      titlePadding: EdgeInsets.only(left: 15, right: 15, top: 15),
      content: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            Center(
              child: Container(
                height: getHeight(context, 0.15),
                width: getWidth(context, 0.30),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Image.network(
                  studentImageAPI(attendanceList.studentGR!),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child; // Image is loaded, show the child (the image itself).
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.person),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Divider(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enroll ',
                      style: TextStyle(
                          fontSize: getSize(context, 2),
                          fontFamily: "mu_reg",
                          color: muColor),
                    ),
                    Text(
                      'Name ',
                      style: TextStyle(
                          fontSize: getSize(context, 2),
                          fontFamily: "mu_reg",
                          color: muColor),
                    ),
                    Text(
                      'Class ',
                      style: TextStyle(
                          fontSize: getSize(context, 2),
                          fontFamily: "mu_reg",
                          color: muColor),
                    ),
                    Text(
                      'Batch ',
                      style: TextStyle(
                          fontSize: getSize(context, 2),
                          fontFamily: "mu_reg",
                          color: muColor),
                    ),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(": ${attendanceList.enrollment!}",
                        style: TextStyle(
                            fontSize: getSize(context, 2),
                            fontFamily: "mu_reg",
                            color: Colors.black),
                      ),
                      Text(": ${attendanceList.studentName!}",
                        style: TextStyle(
                            fontSize: getSize(context, 2),
                            fontFamily: "mu_reg",
                            color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(": ${attendanceList.classname!}",
                        style: TextStyle(
                            fontSize: getSize(context, 2),
                            fontFamily: "mu_reg",
                            color: Colors.black),
                      ),
                      Text(": ${attendanceList.classBatch!.toUpperCase()}",
                        style: TextStyle(
                            fontSize: getSize(context, 2),
                            fontFamily: "mu_reg",
                            color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Mark Extra Attendance", style: AppbarStyle),
        centerTitle: true,
        backgroundColor: muColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Light1),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: fetchAttendanceList,
        backgroundColor: muColor,
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Subject ',
                            style: TextStyle(
                                fontSize: getSize(context, 2),
                                fontFamily: "mu_bold",
                                color: Colors.black),
                          ),
                          Text(
                            'Sem ',
                            style: TextStyle(
                                fontSize: getSize(context, 2),
                                fontFamily: "mu_bold",
                                color: Colors.black),
                          ),
                          Text(
                            'Date ',
                            style: TextStyle(
                                fontSize: getSize(context, 2),
                                fontFamily: "mu_bold",
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ': ${scheduleData?.shortName ?? 'N/A'} - [${scheduleData?.subjectCode ?? 'N/A'}]',
                            style: TextStyle(
                                fontSize: getSize(context, 2),
                                fontFamily: "mu_bold",
                                color: muColor),
                          ),
                          Text(
                            ": ${scheduleData?.sem ?? 'N/A'} - ${scheduleData?.eduType ?? 'N/A'}",
                            style: TextStyle(
                                fontSize: getSize(context, 2),
                                fontFamily: "mu_bold",
                                color: muColor),
                          ),
                          Text(
                            ': ${DateFormat('dd / MM / yyyy').format(selectedDate)}',
                            style: TextStyle(
                                fontSize: getSize(context, 2),
                                fontFamily: "mu_bold",
                                color: muColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  Expanded(
                    child: isLoading
                        ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: muColor,
                          strokeWidth: 3,
                        ),
                      ),
                    )
                        : extraAttendanceDataCopyList != null &&
                        extraAttendanceDataCopyList!.isNotEmpty
                        ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: extraAttendanceDataCopyList!.length,
                      itemBuilder: (context, index) {
                        ExtraAttendanceList attendanceList =
                        extraAttendanceDataCopyList![index];
                        return InkWell(
                          onLongPress: () =>
                              showStudentDetails(attendanceList),
                          onTap: () {
                            setState(() {});
                          },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 2,
                                  color:attendanceList.count !=0
                                      ? muColor
                                      : Colors.red,
                                ),
                                borderRadius:
                                BorderRadius.circular(500.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        width: getWidth(context, 0.6),
                                        // color: Colors.red,
                                        child: Text(
                                          "${attendanceList.enrollment!} - ${attendanceList.studentName}" ,
                                         overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'mu_reg',
                                            fontSize: getSize(context, 2.3),
                                            color: attendanceList.count !=0
                                                ? muColor
                                                : Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(right: 10.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  // Decrease the count if it's greater than 0
                                                  if (extraAttendanceDataCopyList![index].count! > 0) {
                                                    extraAttendanceDataCopyList![index].count = extraAttendanceDataCopyList![index].count!-1;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                height: getSize(context, 4),
                                                width: getSize(context, 4),
                                                child: Icon(Icons.remove,color: Colors.white,),
                                                decoration: BoxDecoration(
                                                  color:attendanceList.count !=0 ? muColor : Colors.red,
                                                  borderRadius: BorderRadius.circular(500)
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            attendanceList.count.toString(),
                                            style: TextStyle(
                                              fontFamily: 'mu_bold',
                                              fontSize: getSize(context, 2.5),
                                              color: attendanceList.count !=0
                                                  ? muColor
                                                  : Colors.red,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10,0,0,0),
                                            child: InkWell(
                                              onTap: (){
                                                setState(() {
                                                  extraAttendanceDataCopyList![index].count = extraAttendanceDataCopyList![index].count!+1;
                                                });
                                              },
                                              child: Container(
                                                height: getSize(context, 4),
                                                width: getSize(context, 4),
                                                child: Icon(Icons.add,color: Colors.white,),
                                                decoration: BoxDecoration(
                                                    color:attendanceList.count !=0 ? muColor : Colors.red,
                                                    borderRadius: BorderRadius.circular(500)
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                        : const Center(
                        child: Text('No students available')),
                  ),
                  // Save button
                  Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton.extended(
                      onPressed: (){
                        ArtSweetAlert.show(
                          context: context,
                          artDialogArgs:
                          ArtDialogArgs(
                            type: ArtSweetAlertType.question,
                            sizeSuccessIcon: 70,
                            confirmButtonText: "SUBMIT", // Hides the confirm button
                            confirmButtonColor: muColor,
                            onConfirm: () async {
                              Get.back();
                              uploadExtraAttendance();
                            },
                            title: "Confirm Attendance",
                            dialogDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        );
                      },
                      backgroundColor: muColor,
                      icon: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Upload",
                        style:
                        TextStyle(fontFamily: 'mu_bold', color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            isUploading?LoadingScreen():Container(),
          ],
        ),
      ),
    );
  }
}
