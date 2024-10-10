import 'package:flutter/material.dart';
import 'package:ict_faculties/Helper/Colors.dart';
import 'package:ict_faculties/Helper/Components.dart';
import 'package:ict_faculties/Widgets/InfoChip.dart';
import 'package:get/get.dart';

class AttendanceCard extends StatelessWidget {
  final String semester;
  final String stream;
  final String subject;
  final String type;
  final String date;
  final String batch;
  final String classCode;
  final String groupType;
  final String time;

  const AttendanceCard({
    Key? key,
    required this.semester,
    required this.stream,
    required this.subject,
    required this.type,
    required this.date,
    required this.batch,
    required this.classCode,
    required this.groupType,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Allow overflow
      children: [
        Container(
          decoration: BoxDecoration(
            color: whitebg,
            border: Border.all(color: muColor, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Card(
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            margin: const EdgeInsets.only(
                top: 15), // Create space for the top label
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subject and Type
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "$subject - $type",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Text(
                      //   date,
                      //   style: const TextStyle(
                      //     fontSize: 12,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Batch, Class, Group
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoChip(label: "Batch", value: batch),
                      InfoChip(label: "Class", value: classCode),
                      InfoChip(label: "Group Type", value: groupType),
                    ],
                  ),
                  const SizedBox(height: 10),
                  horizontalLine(),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 25, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            time,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle Take Attendance
                          Get.toNamed('/markattendance');
                        },
                        style: TextButton.styleFrom(
                          side: BorderSide(color: muColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(500),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: Text("Take Atten.",
                            style: TextStyle(color: muColor)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Positioned Semester and Stream label on top of the card
        Positioned(
          top: -10, // Control the overlap
          left: 10, // Adjust position to your need
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: whitebg,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: muColor, width: 1),
            ),
            child: Row(
              children: [
                Text(
                  semester,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: muColor,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  "(Stream: $stream)",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
