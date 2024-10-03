import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ict_faculties/LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: "/login",
            transition: Transition.fadeIn,
            page: () => const LoginScreen()),
        // GetPage(
        //     name: "/forgotPass",
        //     transition: Transition.fadeIn,
        //     page: () => const ForgotPasswordScreen()
        // ),
        // GetPage(
        //     name: "/dashboard",
        //     transition: Transition.fadeIn,
        //     page: () => const DashboardScreen()
        // ),
        // GetPage(
        //     name: "/placement",
        //     transition: Transition.fadeIn,
        //     page: () => const PlacementScreen()
        // ),
      ],
      initialRoute: "/login",
    );
  }
}
