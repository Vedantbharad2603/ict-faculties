import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ict_faculties/Animations/zoom_in_animation.dart';
import 'package:ict_faculties/Controllers/attendance_controller.dart';
import 'package:ict_faculties/Helper/Components.dart';
import 'package:ict_faculties/Models/reg_attendance_schedule.dart';
import 'package:ict_faculties/Screens/Loading/adaptive_loading_screen.dart';
import 'package:intl/intl.dart';
import 'package:ict_faculties/Helper/Colors.dart';
import 'package:ict_faculties/Helper/Style.dart';
import 'package:ict_faculties/Widgets/Attendance/reg_attendance_card.dart';


class TakeAttendanceScreen extends StatefulWidget {
  const TakeAttendanceScreen({super.key});

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  final AttendanceController attendanceController = Get.put(AttendanceController());
  List<RegSchedule>? scheduleDataList;
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
    List<RegSchedule>? fetchedScheduleDataList = await attendanceController.getSchedule(facultyId,todayDate);
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Attendance Schedule", style: AppbarStyle),
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
                  child:
                  ListView.builder(
                              shrinkWrap: true,
                              itemCount: scheduleDataList!.length,
                              itemBuilder: (context, index) {
                  RegSchedule schedule = scheduleDataList![index];
                  return ZoomInAnimation(
                    delayMilliseconds: 100*index,
                    child: ScheduleCard(
                      context: context,
                      facultyId: facultyId,
                      sem: schedule.sem,
                      eduType: schedule.eduType,
                      subjectId: schedule.subjectID,
                      subjectName: schedule.subjectName,
                      shortSubName: schedule.shortName,
                      subType: schedule.subjectType,
                      subCode: schedule.subjectCode,
                      classID: schedule.classID,
                      classname: schedule.className,
                      batch: schedule.batch,
                      classLoc: schedule.classLocation,
                      lecType: schedule.lecType,
                      startTime: schedule.startTime,
                      endTime: schedule.endTime,
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
