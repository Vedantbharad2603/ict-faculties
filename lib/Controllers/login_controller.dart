import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ict_faculties/Models/faculty.dart';
import 'package:ict_faculties/Network/API.dart';

class LoginController extends GetxController {
  final box = GetStorage();

  Future<bool> login(String username, String password) async {

    try {
      print("USERNAME = $username AND PASSWORD = $password");
      Map<String, String> body = {
        'username': username,
        'password': password
      };
      print('LOGIN === '+validateLoginAPI);
      final response = await http.post(
        Uri.parse(validateLoginAPI),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData != null && responseData['faculties_details'] != null) {
          // Accessing the nested faculties_details
          Faculty userData = Faculty.fromJson(responseData['faculties_details']);

          // Writing data to storage
          box.write('userdata', userData.toJson());
          box.write('loggedin', true);

          return true;
        } else {
          print('Response data is null or faculties_details is missing');
          return false;
        }
      } else {
        print('Failed login: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
  Future<bool> checkVersion(String login, String code) async {
    try {
      Map<String, String> body = {
        'login': login,
        'code': code
      };

      final response = await http.post(
        Uri.parse(validateVersionAPI),
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
