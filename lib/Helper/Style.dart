import 'package:flutter/material.dart';

TextStyle AppbarStyle = TextStyle(color: Colors.white,fontSize: 20,);

TextStyle tagStyle(Color color,double fsize,bool isBold) {
  return TextStyle(color: color,fontFamily: isBold?"mu_Bold":"mu_reg",fontSize: fsize);
}