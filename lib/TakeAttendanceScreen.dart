import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ict_faculties/Helper/Colors.dart';
import 'package:ict_faculties/Helper/Style.dart';
import 'package:ict_faculties/Widgets/AttendanceCard.dart';

class TakeAttendanceScreen extends StatefulWidget {
  const TakeAttendanceScreen({super.key});

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  DateTime selectedDate = DateTime.now();

  final List<Map<String, String>> attendanceList = [
    {
      'semester': 'Sem - 1',
      'stream': 'ICT-DIPLO',
      'subject': 'ESIT [09CT1101]',
      'type': 'Lab/Practical',
      'date': '02/10/2024',
      'batch': '1A',
      'classCode': 'DK1',
      'groupType': 'Mandatory',
      'time': '13:30 TO 14:55',
    },
    {
      'semester': 'Sem - 5',
      'stream': 'ICT-DIPLO',
      'subject': 'CNS [09CT0503]',
      'type': 'Theory',
      'date': '03/10/2024',
      'batch': 'DK1',
      'classCode': 'DK1',
      'groupType': 'Mandatory',
      'time': '09:00 TO 10:30',
    },
    {
      'semester': 'Sem - 3',
      'stream': 'ICT-DIPLO',
      'subject': 'DBMS [09CT1304]',
      'type': 'Theory',
      'date': '04/10/2024',
      'batch': 'DK1',
      'classCode': 'DK1',
      'groupType': 'Mandatory',
      'time': '13:30 TO 14:55',
    },
    {
      'semester': 'Sem - 3',
      'stream': 'ICT-DIPLO',
      'subject': 'DBMS [09CT1304]',
      'type': 'Lab/Practical',
      'date': '08/10/2024',
      'batch': '1A',
      'classCode': 'DK1',
      'groupType': 'Mandatory',
      'time': '13:30 TO 14:25',
    }
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Format the selected date as 'dd/MM/yyyy' (e.g., '27/09/2024')
    String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);

    // Filter the attendance list based on the selected date
    List<Map<String, String>> filteredList =
        attendanceList.where((item) => item['date'] == formattedDate).toList();

    return Scaffold(
      backgroundColor: whitebg,
      appBar: AppBar(
        title: Text("Attendance", style: AppbarStyle),
        centerTitle: true,
        backgroundColor: muColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Light1),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Date picker button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: muColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Attendance list
          Expanded(
            child: filteredList.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          AttendanceCard(
                            semester: filteredList[index]['semester']!,
                            stream: filteredList[index]['stream']!,
                            subject: filteredList[index]['subject']!,
                            type: filteredList[index]['type']!,
                            date: filteredList[index]['date']!,
                            batch: filteredList[index]['batch']!,
                            classCode: filteredList[index]['classCode']!,
                            groupType: filteredList[index]['groupType']!,
                            time: filteredList[index]['time']!,
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No attendance records for this date.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
