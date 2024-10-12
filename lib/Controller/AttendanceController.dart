import 'dart:convert';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:ict_faculties/Model/ScheduleModel.dart';
import '../API/API.dart';

class AttendanceController extends GetxController {

  Future<List<Schedule>?> getSchedule(int sid,String date) async {
    try {
      Map<String, dynamic> body = {
        'f_id': sid,
        'date':date
      };

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
}
