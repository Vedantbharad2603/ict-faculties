import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ict_faculties/Screens/AddStudentEngaged.dart';
import 'package:ict_faculties/Screens/EngagedStudentScreen.dart';
import 'package:ict_faculties/Screens/MarkAttendance.dart';
import 'package:ict_faculties/Screens/PlacementScreen.dart';
import 'package:ict_faculties/Screens/TakeAttendanceScreen.dart';

import 'Screens/DashboardScreen.dart';
import 'Screens/ForgotPasswordScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: "/splashscreen",
            transition: Transition.fadeIn,
            page: () => SplashScreen()),
        GetPage(
            name: "/login",
            transition: Transition.fadeIn,
            page: () => const LoginScreen()),
        GetPage(
            name: "/forgotPass",
            transition: Transition.fadeIn,
            page: () => const ForgotPasswordScreen()),
        GetPage(
            name: "/dashboard",
            transition: Transition.fadeIn,
            page: () => const DashboardScreen()),
        GetPage(
            name: "/engagedStudent",
            transition: Transition.fadeIn,
            page: () => const EngagedStudent()),
        GetPage(
            name: "/addEngagedStudent",
            transition: Transition.fadeIn,
            page: () => const Addstudentengaged()),
        GetPage(
            name: "/takeAttendance",
            transition: Transition.fadeIn,
            page: () => const TakeAttendanceScreen()),
        GetPage(
            name: "/markattendance",
            transition: Transition.fadeIn,
            page: () => const MarkAttendance()),
      ],
      initialRoute: "/splashscreen",
    );
  }
}
