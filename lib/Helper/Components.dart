import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ict_faculties/Helper/Colors.dart';

import 'Style.dart';

double getHeight(context, double i) {
  double result = MediaQuery.of(context).size.height * i;
  return result;
}

double getWidth(context, double i) {
  double result = MediaQuery.of(context).size.width * i;
  return result;
}

double getSize(context, double i) {
  double result = MediaQuery.of(context).size.width * i / 50;
  return result;
}

Widget horizontalLine() {
  return const SizedBox(
    height: 1.5,
    width: double.infinity,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: Color.fromARGB(40, 0, 0, 0),
      ),
    ),
  );
}

Widget BlackTag(context, Color? color, String? Line1, String? Line2,
    Widget? imageWidget, bool isReverse) {
  return Container(
    alignment: Alignment.centerRight,
    child: Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Conditional alignment
      children: isReverse
          ? [
              Container(
                height: 65,
                width: 50,
                decoration: BoxDecoration(
                  color: color ?? Colors.black,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(500),
                  ),
                ),
              ),
              Container(
                height: 65,
                width: 300,
                decoration: BoxDecoration(
                  color: color ?? Colors.black,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(500),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 55,
                        width: 55,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(500))),
                        child: imageWidget,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: getWidth(context, 0.5),
                            child: Text(
                              Line1 ?? "Loading...",
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: tagStyle(Colors.white, 18, true),
                            ),
                          ),
                          Text(
                            Line2 ?? "Loading...",
                            overflow: TextOverflow.ellipsis,
                            style: tagStyle(Light2, 15, false),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]
          : [
              Container(
                height: 65,
                width: 300,
                decoration: BoxDecoration(
                  color: color ?? Colors.black,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(500),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              Line1 ?? "Loading...",
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: tagStyle(Colors.white, 18, true),
                            ),
                          ),
                          Text(
                            Line2 ?? "Loading...",
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: tagStyle(Light2, 15, false),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              500), // Clipping the image into a circle
                          child: imageWidget),
                    ),
                  ],
                ),
              ),
              Container(
                height: 65,
                width: 50,
                decoration: BoxDecoration(
                  color: color ?? Colors.black,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(500),
                  ),
                ),
              ),
            ],
    ),
  );
}

Widget TapIcons(
  context,
  String name,
  double nameSize,
  String iconFilename,
  double iconSize,
  String route,
  routeArg,
) {
  return InkWell(
    onTap: () => Get.toNamed(route, arguments: routeArg),
    child: Container(
      child: Column(
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              color: muGrey,
              borderRadius: BorderRadius.circular(15), // rounded corners
            ),
            child: Center(
              child: Container(
                height: iconSize,
                width: iconSize,
                decoration: BoxDecoration(

                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/MainIcons/$iconFilename"), // replace with your asset path
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: getHeight(context, 0.005),),
          Container(
              height:getHeight(context, 0.05),
              width: getWidth(context, 0.25),
              child: Center(
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'mu_reg',
                    color: muColor,
                      height: 1,
                    fontSize: getSize(context, nameSize)
                  ),
                  // softWrap: true,
                  textAlign: TextAlign.center,
                ),
              )
          )
        ],
      ),
    ),
  );
}

Heading1(context, String str, double size, double leftPad) {
  return Padding(
    padding: EdgeInsets.only(top: 8.0, bottom: 4, left: leftPad),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            height: getSize(context, size * 1.5),
            width: getSize(context, size * 0.35),
            decoration: BoxDecoration(
                color: muColor, borderRadius: BorderRadius.circular(500)),
          ),
        ),
        Container(
          child: Text(
            str,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: "mu_bold",
              fontSize: getSize(context, size),
              letterSpacing: 0.1,
            ),
          ),
        ),
      ],
    ),
  );
}

scheduleCard(
    context,
    int facultyId,
    int sem,
    String eduType,
    int subjectId,
    String subjectName,
    String shortSubName,
    String subType,
    String subCode,
    classID,
    String classname,
    String batch,
    String classLoc,
    String startTime,
    String endTime,
    DateTime selectedDate,
    arg) {
  return Padding(
    padding: EdgeInsets.all(getSize(context, 1.5)),
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: getSize(context, 2)),
          child: Container(
            width: double.infinity,
            height: getHeight(context, 0.25),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(getSize(context, 2.5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 5,
                  ),
                ]),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: getSize(context, 5),
                      left: getSize(context, 3),
                      right: getSize(context, 3)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "$shortSubName [$subCode]",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "mu_reg",
                                fontWeight: FontWeight.bold,
                                fontSize: getSize(context, 2.25)),
                          ),
                          Text(
                            "  - $subType",
                            style: TextStyle(
                                color: muColor,
                                fontFamily: "mu_reg",
                                fontSize: getSize(context, 2.25)),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Class   :   ",
                                style: TextStyle(
                                    color: muColor,
                                    fontFamily: "mu_reg",
                                    fontWeight: FontWeight.bold,
                                    fontSize: getSize(context, 2.25)),
                              ),
                              Text(
                                classname,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "mu_reg",
                                    fontWeight: FontWeight.bold,
                                    fontSize: getSize(context, 2.25)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Batch   :   ",
                                style: TextStyle(
                                    color: muColor,
                                    fontFamily: "mu_reg",
                                    fontWeight: FontWeight.bold,
                                    fontSize: getSize(context, 2.25)),
                              ),
                              Text(
                                batch.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "mu_reg",
                                    fontWeight: FontWeight.bold,
                                    fontSize: getSize(context, 2.25)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.alarm,
                                    color: muColor,
                                    size: getSize(context, 3.5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "${startTime.substring(0, 5)} to ${endTime.substring(0, 5)}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "mu_reg",
                                          fontSize: getSize(context, 2.25)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: muColor,
                                    size: getSize(context, 3.5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      classLoc,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "mu_reg",
                                          fontSize: getSize(context, 2.25)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () =>
                                    Get.toNamed("/markattendance", arguments: {
                                  'faculty_id': facultyId,
                                  'lec_data': arg,
                                  'selected_date': selectedDate,
                                }),
                                child: Card(
                                  color: muGrey,
                                  child: Container(
                                    height: getHeight(context, 0.05),
                                    width: getWidth(context, 0.4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(500),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Take Attendance",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: muColor,
                                            fontFamily: "mu_reg",
                                            fontSize: getSize(context, 2)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Container(
            width: getWidth(context, 0.42),
            height: getHeight(context, 0.045),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(500),
                border: Border.all(color: muColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sem - $sem",
                  style: TextStyle(
                      color: muColor,
                      fontFamily: "mu_reg",
                      fontSize: getSize(context, 2.25)),
                ),
                Text(
                  eduType,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "mu_bold",
                      fontSize: getSize(context, 2.25)),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
