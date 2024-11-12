import 'dart:ui';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ict_faculties/API/API.dart';
import 'package:ict_faculties/Helper/Components.dart';
import 'package:ict_faculties/Model/AttendanceListModel.dart';
import 'package:ict_faculties/Screens/LoadingScreen.dart';
import 'package:intl/intl.dart';
import '../Controller/AttendanceController.dart';
import '../Helper/Colors.dart';
import '../Helper/Style.dart';
import '../Model/MarkAttendanceModel.dart';
import '../Model/ScheduleModel.dart';

class MarkAttendance extends StatefulWidget {
  const MarkAttendance({super.key});

  @override
  State<MarkAttendance> createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  List<AttendanceList>? attendanceDataList;
  List<AttendanceList>? attendanceDataCopyList;
  List<MarkAttendanceData> uploadAttendanceDataList =[];

  bool isLoading = false;
  bool isUploading = false;
  bool isSelectAll = true;
  late DateTime selectedDate;
  late int facultyId;
  Schedule? scheduleData;

  @override
  void initState() {
    super.initState();
    setState(() {
      scheduleData = Get.arguments['lec_data'];
      selectedDate = Get.arguments['selected_date'];
      facultyId = Get.arguments['faculty_id'];
    });
    fetchAttendanceList();
  }

  Future<void> fetchAttendanceList() async {
    setState(() {
      isLoading = true;
    });
    String formatedSelectedDate = DateFormat("yyyy-MM-dd").format(selectedDate);
    List<AttendanceList>? fetchedAttendanceDataList =
    await attendanceController.getAttendanceList(
        scheduleData!.subjectID,
        scheduleData!.classID,
        facultyId,
        formatedSelectedDate,
        scheduleData!.startTime);
    if (!mounted) return;
    setState(() {
      attendanceDataList = fetchedAttendanceDataList;


      print("------------------------------------------------\n AttendanceDataList = ");
      for (var item in attendanceDataList!) {
        print(item.toString());
      }

      createAttendanceCopy();
      isLoading = false;
    });
  }
  Future<void> createAttendanceCopy() async {
    setState(() {
      // Create a copy of the attendance list and update status for 'na' to 'pr'
      attendanceDataCopyList = attendanceDataList?.map((attendance) {
        // Ensure the item is of type AttendanceList
        AttendanceList copiedAttendance = attendance.copyWith(
          newStatus: attendance.status == 'na' ? 'pr' : attendance.status,
        );
        return copiedAttendance;
      }).toList();
    });
    print("------------------------------------------------\n CopyiedAttendanceDataList = ");
    for (var item in attendanceDataCopyList!) {
      print(item.toString());
    }
  }


  Future<void> uploadAttendance() async {
    setState(() {
      isUploading = true;
    });

    // Loop through each student and add only modified records to the list
    for (int i = 0; i < attendanceDataCopyList!.length; i++) {
      // Check if the status in attendanceDataCopyList is different from attendanceDataList
      if (attendanceDataList![i].status != attendanceDataCopyList![i].status) {
        uploadAttendanceDataList.add(MarkAttendanceData(
          subjectId: scheduleData!.subjectID,
          facultyId: facultyId,
          studentId: attendanceDataCopyList![i].studentID,
          date: DateFormat("yyyy-MM-dd").format(selectedDate),
          status: attendanceDataCopyList![i].status,
          classStartTime: scheduleData!.startTime,
          classEndTime: scheduleData!.endTime,
          lecType: scheduleData!.lecType,
        ));
      }
    }

    // Print to verify the data being uploaded
    print("------------------------------------------------\n Upload Time = ");
    for (var item in uploadAttendanceDataList) {
      print(item.toString());
    }

    // Check if there is any data to upload
    if (uploadAttendanceDataList.isNotEmpty) {
      bool success = await attendanceController.uploadAttendance(uploadAttendanceDataList);

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



  void showStudentDetails(AttendanceList attendanceList) {
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

  // Function to handle Select All checkbox behavior
  void handleSelectAll(bool? value) {
    setState(() {
      isSelectAll = value!;
      for (var attendanceList in attendanceDataCopyList!) {
        if (attendanceList.status != 'oe' && attendanceList.status != 'gl') {
          attendanceList.status = isSelectAll ? 'pr' : 'ab';
        }
      }
    });
  }

  // Check if all non-disabled checkboxes are selected
  bool checkIfAllSelected() {
    return attendanceDataCopyList!.where((attendanceList) {
      return attendanceList.status != 'oe' && attendanceList.status != 'gl';
    }).every((attendanceList) => attendanceList.status == 'pr');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mark Attendance", style: AppbarStyle),
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
                            'Class ',
                            style: TextStyle(
                                fontSize: getSize(context, 2),
                                fontFamily: "mu_bold",
                                color: Colors.black),
                          ),
                          Text(
                            'Time ',
                            style: TextStyle(
                                fontSize: getSize(context, 2),
                                fontFamily: "mu_bold",
                                color: Colors.black),
                          ),
                          Text(
                            'Location ',
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
                            ': ${scheduleData!.shortName} - [${scheduleData!.subjectCode}]',
                            style: TextStyle(
                                fontSize: getSize(context, 2),
                                fontFamily: "mu_bold",
                                color: muColor),
                          ),
                          Row(
                            children: [
                              Text(
                                ": ${scheduleData!.className}",
                                style: TextStyle(
                                    fontSize: getSize(context, 2),
                                    fontFamily: "mu_bold",
                                    color: muColor),
                              ),
                              SizedBox(width: getWidth(context, 0.1)),
                              Text(
                                'Batch ',
                                style: TextStyle(
                                    fontSize: getSize(context, 2),
                                    fontFamily: "mu_bold",
                                    color: Colors.black),
                              ),
                              Text(
                                ": ${scheduleData!.batch.toUpperCase()}",
                                style: TextStyle(
                                    fontSize: getSize(context, 2),
                                    fontFamily: "mu_bold",
                                    color: muColor),
                              ),
                            ],
                          ),
                          Text(
                            ': ${scheduleData!.startTime.substring(0, 5)}  to  ${scheduleData!.endTime.substring(0, 5)}',
                            style: TextStyle(
                                fontSize: getSize(context, 2),
                                fontFamily: "mu_bold",
                                color: muColor),
                          ),
                          Text(
                            ': ${scheduleData!.classLocation}',
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: isSelectAll,
                        onChanged: (value) {
                          handleSelectAll(value);
                        },
                        activeColor: muColor,
                      ),
                      Text(
                        'Select All',
                        style: TextStyle(
                            fontFamily: "mu_bold", fontSize: getSize(context, 2.5)),
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
                        : attendanceDataCopyList != null &&
                        attendanceDataCopyList!.isNotEmpty
                        ? GridView.builder(
                      shrinkWrap: true,
                      itemCount: attendanceDataCopyList!.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 items per row
                        crossAxisSpacing:
                        10.0, // spacing between items horizontally
                        mainAxisSpacing:
                        5.0, // spacing between items vertically
                        childAspectRatio:
                        3, // controls the size of each tile, adjust this for the desired look
                      ),
                      itemBuilder: (context, index) {
                        AttendanceList attendanceList =
                        attendanceDataCopyList![index];
                        bool isDisabled = attendanceList.status == 'oe' ||
                            attendanceList.status == 'gl';

                        return InkWell(
                          onLongPress: () =>
                              showStudentDetails(attendanceList),
                          onTap: isDisabled
                              ? null
                              : () {
                            setState(() {
                              attendanceList.status =
                              attendanceList.status == 'pr'
                                  ? 'ab'
                                  : 'pr';
                              isSelectAll = checkIfAllSelected();
                            });
                          },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              height: getHeight(context, 0.05),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 2,
                                  color: isDisabled
                                      ? Colors.green
                                      : attendanceList.status == "pr"
                                      ? muColor
                                      : Colors.red,
                                ),
                                borderRadius:
                                BorderRadius.circular(500.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      attendanceList.enrollment!,
                                      style: TextStyle(
                                        fontFamily: 'mu_reg',
                                        fontSize: getSize(context, 2.3),
                                        color: isDisabled
                                            ? Colors.green
                                            : attendanceList.status ==
                                            "pr"
                                            ? muColor
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: attendanceList.status == 'pr',
                                    onChanged: isDisabled
                                        ? null
                                        : (value) {
                                      setState(() {
                                        attendanceList.status =
                                        value! ? 'pr' : 'ab';
                                        isSelectAll =
                                            checkIfAllSelected();
                                      });
                                    },
                                    checkColor: Colors.white,
                                    side: BorderSide(
                                      color: isDisabled
                                          ? Colors.green
                                          : Colors.red,
                                      width: 2,
                                    ),
                                    activeColor: isDisabled
                                        ? Colors.green
                                        : attendanceList.status == "pr"
                                        ? muColor
                                        : Colors.red,
                                    fillColor: isDisabled
                                        ? MaterialStateProperty
                                        .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                        return Colors
                                            .green; // Disabled state color
                                      },
                                    )
                                        : null,
                                  ),
                                ],
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
                              uploadAttendance();
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
