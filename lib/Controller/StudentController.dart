import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../API/API.dart';

class StudentController extends GetxController {
  Future<List<dynamic>?> getStudentsByCC(int fid) async {
    try {
      Map<String, dynamic> body = {
        'f_id':fid,
      };

      final response = await http.post(
        Uri.parse(getStudentByCCAPI),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        List<dynamic> StudentDataList = responseData.toList();
        print(StudentDataList);
        return StudentDataList;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  Future<List<dynamic>?> getEngageStudentsByCC(int fid) async {
    try {
      Map<String, dynamic> body = {
        'f_id':fid,
      };

      final response = await http.post(
        Uri.parse(getEngagedStudentByCCAPI),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        List<dynamic> EngagedStudentDataList = responseData.toList();
        print(EngagedStudentDataList);
        return EngagedStudentDataList;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
