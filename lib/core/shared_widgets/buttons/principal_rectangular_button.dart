import 'package:calculix/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget principalRectangularButton({
  required Function()? onPressed,
  required BuildContext context,
}) {
  return SizedBox(
    width: 80.w,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,

        padding: EdgeInsets.symmetric(vertical: 1.h),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
        elevation: 8,
      ),
      child: Text(
        'SIGN IN',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
