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
                              overflow: TextOverflow.clip,
                              softWrap: false,
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
                              overflow: TextOverflow.clip,
                              softWrap: false,
                              style: tagStyle(Colors.white, 18, true),
                            ),
                          ),
                          Text(
                            Line2 ?? "Loading...",
                            overflow: TextOverflow.clip,
                            softWrap: false,
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

Widget TapIcons(String name, double nameSize, String iconFilename,
    double iconSize, String route) {
  return InkWell(
    onTap: () => Get.toNamed(route),
    child: Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            color: muGrey,
            borderRadius: BorderRadius.circular(15), // rounded corners
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
            color: muColor,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
