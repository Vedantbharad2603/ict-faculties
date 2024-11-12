import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ict_faculties/Model/AttendanceListModel.dart';
import 'package:ict_faculties/Model/ScheduleModel.dart';
import '../API/API.dart';
import '../Model/MarkAttendanceModel.dart';

class AttendanceController extends GetxController {
  Future<List<Schedule>?> getSchedule(int sid, String date) async {
    try {
      Map<String, dynamic> body = {'f_id': sid, 'date': date};

      final response = await http.post(
        Uri.parse(getScheduleAPI),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        List<Schedule> scheduleDataList = responseData
            .map((scheduleData) => Schedule.fromJson(scheduleData))
            .toList();

        return scheduleDataList;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<AttendanceList>?> getAttendanceList(
      int sub_id, int cid, int fid,String cdate, String stime) async {
    try {
      Map<String, dynamic> body = {
        'sub_id': sub_id,
        'c_id': cid,
        'f_id':fid,
        'c_date': cdate,
        's_time': stime
      };

      final response = await http.post(
        Uri.parse(getAttendanceListAPI),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        List<AttendanceList> AttendanceDataList = responseData
            .map((attendanceData) => AttendanceList.fromJson(attendanceData))
            .toList();

        return AttendanceDataList;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<bool> uploadAttendance(List<MarkAttendanceData> attendanceData) async {
    try {
      // Ensure the attendance data is not empty
      if (attendanceData.isEmpty) {
        print('No attendance data available to upload');
        return false;
      }

      // Convert each attendance record to JSON using the model's toJson method
      List<Map<String, dynamic>> body = attendanceData.map((data) => data.toJson()).toList();

      print("----------------------------------------------\n Sending data: ");
      print(json.encode(body));

      final response = await http.post(
        Uri.parse(uploadAttendanceAPI),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      print(uploadAttendanceAPI);
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
