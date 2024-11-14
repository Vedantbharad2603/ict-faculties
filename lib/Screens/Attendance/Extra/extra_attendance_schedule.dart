import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ict_faculties/Animations/zoom_in_animation.dart';
import 'package:ict_faculties/Helper/Components.dart';
import 'package:ict_faculties/Models/extra_attendance_schedule.dart';
import 'package:ict_faculties/Screens/Loading/adaptive_loading_screen.dart';
import 'package:ict_faculties/Widgets/Attendance/extra_attendance_card.dart';
import 'package:intl/intl.dart';
import 'package:ict_faculties/Helper/Colors.dart';
import 'package:ict_faculties/Helper/Style.dart';

import '../../../Controllers/attendance_controller.dart';

class ExtraAttendanceSchedule extends StatefulWidget {
  const ExtraAttendanceSchedule({super.key});

  @override
  State<ExtraAttendanceSchedule> createState() => _ExtraAttendanceScheduleState();
}

class _ExtraAttendanceScheduleState extends State<ExtraAttendanceSchedule> {
  final AttendanceController attendanceController = Get.put(AttendanceController());
  List<ExtraSchedule>? scheduleDataList;
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  late int facultyId;

  @override
  void initState() {
    super.initState();
    fetchSchedule();
  }
  Future<void> fetchSchedule() async {
    setState(() {
      isLoading=true;
    });
    facultyId = Get.arguments['faculty_id'];
    // String todayDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    List<ExtraSchedule>? fetchedExtraScheduleDataList = await attendanceController.getExtraSchedule(facultyId);
    if (!mounted) return;
    setState(() {
      if (fetchedExtraScheduleDataList != null) {
        scheduleDataList= fetchedExtraScheduleDataList;
        print(scheduleDataList);
      }
      isLoading = false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primaryColor: muColor, // Change the calendar header and active dates
            colorScheme: ColorScheme.light(
              primary: muColor, // Header and active dates
              onPrimary: Colors.white, // Text color of the header
              onSurface: muColor, // Text color of inactive dates
            ),
            dialogBackgroundColor: Colors.white, // Background color of the date picker
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        scheduleDataList = null;
        fetchSchedule();
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    String formattedDate = DateFormat('dd-MMM-yyyy').format(selectedDate);
    // Filter the attendance list based on the selected date
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Extra Attendance Schedule", style: AppbarStyle),
        centerTitle: true,
        backgroundColor: muColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Light1),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body:  RefreshIndicator.adaptive(
        onRefresh: fetchSchedule,
        color: backgroundColor,
        backgroundColor: muColor,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Heading1(
                  context,
                  DateTime.now().difference(selectedDate).inDays == 0
                      ? "Today ($formattedDate)"
                      : formattedDate,
                  2.5,15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: IconButton(onPressed :()=>_selectDate(context),
                      icon: Icon(
                        Icons.calendar_month,
                        color: muColor,
                        size: getSize(context, 3.5),
                      )),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(),
            ),
            isLoading ? AdaptiveLoadingScreen()
                :scheduleDataList != null && scheduleDataList!.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: scheduleDataList!.length,
                itemBuilder: (context, index) {
                  ExtraSchedule schedule = scheduleDataList![index];
                  return ZoomInAnimation(
                    delayMilliseconds: 100*index,
                    child: ExtraScheduleCard(
                      context: context,
                      facultyId: facultyId,
                      semId: schedule.semId,
                      sem: schedule.sem,
                      eduType: schedule.eduType,
                      lecType: schedule.lecType,
                      subjectId: schedule.subjectID,
                      subjectName: schedule.subjectName,
                      shortSubName: schedule.shortName,
                      subType: schedule.subjectType,
                      subCode: schedule.subjectCode,
                      selectedDate: selectedDate,
                      arg: schedule,
                    ),
                  );

                },
              ),
            ): Center(
              child: Text(
                "No schedule",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
