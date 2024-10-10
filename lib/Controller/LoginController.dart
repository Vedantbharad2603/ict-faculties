import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ict_faculties/Model/User_model.dart';
import '../API/API.dart';
// import '../Model/UserDataModel.dart';

class LoginController extends GetxController {
  final box = GetStorage();

  Future<bool> login(String username, String password) async {
    try {
      Map<String, String> body = {
        'username': username,
        'password': password,
      };

      final response = await http.post(
        Uri.parse(validateLogin),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData != null && responseData['faculties_details'] != null) {
          // Accessing the nested faculties_details
          User userData = User.fromJson(responseData['faculties_details']);

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
