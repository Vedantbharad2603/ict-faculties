import 'package:flutter/material.dart';
import 'package:ict_faculties/Helper/Style.dart';

class PlacementScreen extends StatefulWidget {
  const PlacementScreen({super.key});

  @override
  State<PlacementScreen> createState() => _PlacementScreenState();
}

class _PlacementScreenState extends State<PlacementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Placement",
          style: AppbarStyle,
        ),
      ),
    );
  }
}
