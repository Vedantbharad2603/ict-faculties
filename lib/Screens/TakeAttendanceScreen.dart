import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ict_faculties/Helper/Components.dart';
import 'package:ict_faculties/Model/ScheduleModel.dart';
import 'package:intl/intl.dart';
import 'package:ict_faculties/Helper/Colors.dart';
import 'package:ict_faculties/Helper/Style.dart';
import 'package:ict_faculties/Widgets/AttendanceCard.dart';

import '../Controller/AttendanceController.dart';

class TakeAttendanceScreen extends StatefulWidget {
  const TakeAttendanceScreen({super.key});

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  final AttendanceController attendanceController = Get.put(AttendanceController());
  List<Schedule>? scheduleDataList;
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
    String todayDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    List<Schedule>? fetchedScheduleDataList = await attendanceController.getSchedule(facultyId,todayDate);
    if (!mounted) return;
    setState(() {
      if (fetchedScheduleDataList != null) {
        scheduleDataList= fetchedScheduleDataList;
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
      backgroundColor: muGrey,
      appBar: AppBar(
        title: Text("Student Attendance", style: AppbarStyle),
        centerTitle: true,
        backgroundColor: muColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Light1),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchSchedule,
        color: whitebg,
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
            isLoading ? Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(color: muColor, strokeWidth: 3,),
            ))
                : scheduleDataList != null && scheduleDataList!.isNotEmpty
                ? Expanded(
                  child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: scheduleDataList!.length,
                              itemBuilder: (context, index) {
                  Schedule schedule = scheduleDataList![index];
                  return scheduleCard(
                      context,
                      facultyId,
                      schedule.sem,
                      schedule.eduType,
                      schedule.subjectID,
                      schedule.subjectName,
                      schedule.shortName,
                      schedule.subjectType,
                      schedule.subjectCode,
                      schedule.classID,
                      schedule.className,
                      schedule.batch,
                      schedule.classLocation,
                      schedule.startTime,
                      schedule.endTime,
                      selectedDate,
                      schedule
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
