import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_colors.dart';

class CustomTextSty {
  static TextStyle Text24Stly700 = GoogleFonts.inter(
    fontSize: 24.0.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static TextStyle Text20Stly500 = GoogleFonts.roboto(
    fontSize: 20.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.purple,
  );

  static TextStyle style14NTextColor = GoogleFonts.openSans(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w400,
  );
}
