import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../API/API.dart';
import '../Model/UserDataModel.dart';
// import '../Model/UserDataModel.dart';

class LoginController extends GetxController {
  final box = GetStorage();

  Future<bool> login(String username, String password) async {
    try {
      print("USERNAME = $username AND PASSWORD = $password");
      Map<String, String> body = {
        'username': username,
        'password': password
      };

      final response = await http.post(
        Uri.parse(validateLoginAPI),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData != null && responseData['faculties_details'] != null) {
          // Accessing the nested faculties_details
          UserData userData = UserData.fromJson(responseData['faculties_details']);

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
}
