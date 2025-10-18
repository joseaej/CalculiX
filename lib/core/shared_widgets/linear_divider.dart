
import 'package:calculix/core/config/app_colors.dart';
import 'package:flutter/material.dart';

Widget lineWithText({
  required String text,
  Color lineColor = AppColors.primaryBlue,
  double thickness = 2.0,
  double padding = 16.0,
}) {
  return Row(
    children: [
      Expanded(
        child: Divider(
          color: lineColor,
          thickness: thickness,
        ),
      ),
      
      Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      Expanded(
        child: Divider(
          color: lineColor,
          thickness: thickness,
        ),
      ),
    ],
  );
}