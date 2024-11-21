import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ict_faculties/Binding/extra_mark_attendance_binding.dart';
import 'package:ict_faculties/Binding/reg_attendance_schedule_binding.dart';
import 'package:ict_faculties/Binding/reg_mark_attendance_binding.dart';
import 'package:ict_faculties/Binding/splash_binding.dart';
import 'package:ict_faculties/Screens/Attendance/Extra/extra_mark_attendance.dart';
import 'package:ict_faculties/Screens/Exception/no_schedule_available.dart';
import 'package:ict_faculties/Screens/Exception/no_students_available.dart';
import 'package:ict_faculties/Screens/Exception/service_not_available.dart';
import 'package:ict_faculties/Screens/StudentEngage/add_engage_student.dart';
import 'package:ict_faculties/Screens/Attendance/Extra/extra_attendance_schedule.dart';
import 'package:ict_faculties/Screens/StudentEngage/engage_students_list.dart';
import 'Binding/extra_attendance_schedule_binding.dart';
import 'Screens/Attendance/Regular/reg_mark_attendance.dart';
import 'Screens/Attendance/Regular/reg_attendance_schedule.dart';
import 'Screens/Home/home_dashboard.dart';
import 'Screens/Authentication/forgot_password.dart';
import 'Screens/Authentication/login.dart';
import 'Screens/Splash/main_splash.dart';

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
            binding: SplashBinding(),
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
            page: () => const EngagedStudentScreen()),
        GetPage(
            name: "/addEngagedStudent",
            transition: Transition.fadeIn,
            page: () => const Addstudentengaged()),
        GetPage(
            name: "/regAttendanceSchedule",
            transition: Transition.fadeIn,
            binding: RegAttendanceScheduleBinding(),
            page: () => const RegAttendanceSchedule()
        ),
        GetPage(
            name: "/markARegAttendance",
            transition: Transition.fadeIn,
            binding: RegMarkAttendanceBinding(),
            page: () => const RegMarkAttendance()),
        GetPage(
            name: "/extraAttendanceSchedule",
            transition: Transition.fadeIn,
            binding: ExtraAttendanceScheduleBinding(),
            page: () => const ExtraAttendanceSchedule()),
        GetPage(
            name: "/markExtraAttendance",
            transition: Transition.fadeIn,
            binding: ExtraMarkAttendanceBinding(),
            page: () => const MarkExtraAttendance()),
        GetPage(
            name: "/test",
            transition: Transition.fadeIn,
            page: () => const NoScheduleAvailable()),
        GetPage(
            name: "/serverFailed",
            transition: Transition.fadeIn,
            page: () => const ServiceNotAvailable()),
      ],
      initialRoute: "/splashscreen",
    );
  }
}
