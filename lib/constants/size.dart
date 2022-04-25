import 'package:flutter/material.dart';

SizedBox sizedBox(double height, double width) => SizedBox(
      height: height,
      width: width,
    );

Size size(BuildContext context) => MediaQuery.of(context).size;
