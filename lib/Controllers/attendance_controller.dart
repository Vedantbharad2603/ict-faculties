import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ict_faculties/Models/extra_attendance_list.dart';
import 'package:ict_faculties/Models/extra_attendance_schedule.dart';
import 'package:ict_faculties/Models/extra_mark_attendance_data.dart';
import 'package:ict_faculties/Models/reg_attendance_list.dart';
import 'package:ict_faculties/Models/reg_attendance_schedule.dart';
import 'package:ict_faculties/Models/reg_mark_attendance_data.dart';
import 'package:ict_faculties/Network/API.dart';

class AttendanceController extends GetxController {






  Future<bool> uploadExtraAttendance(List<ExtraMarkAttendanceData> extraAttendanceData) async {
    try {
      // Ensure the attendance data is not empty
      if (extraAttendanceData.isEmpty) {
        print('No attendance data available to upload');
        return false;
      }

      // Convert each attendance record to JSON using the model's toJson method
      List<Map<String, dynamic>> body = extraAttendanceData.map((data) => data.toJson()).toList();

      print("----------------------------------------------\n Sending data: ");
      print(json.encode(body));

      final response = await http.post(
        Uri.parse(uploadExtraAttendanceAPI),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        print('Attendance uploaded successfully');
        return true;
      } else {
        print('Failed to upload attendance. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error uploading attendance: $e');
      return false;
    }
  }

  Future<bool> upsertEngagedStudent(int? studentId,int? facultyId,String? reason,String? type,String? startDate,String? endDate) async {
    print('$studentId --- $facultyId --- $reason --- $type --- $startDate --- $endDate');
    try {
      Map<String, dynamic> body = {
        'student_info_id':studentId,
        'reason':reason,
        'type':type,
        'faculty_info_id':facultyId,
        'start_date':startDate,
        'end_date':endDate
      };

      final response = await http.post(
        Uri.parse(upsertEngagedStudentAPI),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
