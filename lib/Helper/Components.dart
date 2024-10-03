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

Widget BlackTag(Color? color, double? height, double? width, String? Line1,
    String? Line2, Image? img, bool isReverse) {
  return Container(
    alignment: Alignment.centerRight,
    child: Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Conditional alignment
      children: isReverse
          ? [
              Container(
                height: height ?? 65,
                width: width ?? 50,
                decoration: BoxDecoration(
                  color: color ?? Colors.black,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(500),
                  ),
                ),
              ),
              Container(
                height: height ?? 65,
                width: width ?? 300,
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
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              500), // Clipping the image into a circle
                          child: img),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Line1 ?? "Loading...",
                            style: tagStyle(Colors.white, 18, true),
                          ),
                          Text(
                            Line2 ?? "Loading...",
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
                height: height ?? 65,
                width: width ?? 300,
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
                          Text(
                            Line1 ?? "Loading...",
                            style: tagStyle(Colors.white, 18, true),
                          ),
                          Text(
                            Line2 ?? "Loading...",
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
                          child: img),
                    ),
                  ],
                ),
              ),
              Container(
                height: height ?? 65,
                width: width ?? 50,
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

Widget TapIcons(String name, double nameSize, String iconFilename,
    double iconSize, String route) {
  return InkWell(
    onTap: () => Get.toNamed(route),
    child: Container(
      height: 200,
      width: 100,
      child: Column(
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              color: Colors.white, // background color for the icon
              borderRadius: BorderRadius.circular(20), // rounded corners
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: iconSize,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/MainIcons/$iconFilename"), // replace with your asset path
                      fit: BoxFit.contain,
                    ),
                  ),
                ), // Spacing between icon and text
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: nameSize,
              fontFamily: "mu_reg",
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
