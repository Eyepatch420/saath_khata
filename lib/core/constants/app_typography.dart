import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTypography {
  // No color set — inherits from DefaultTextStyle so dark/light mode adapts automatically.
  static TextStyle get h1 => GoogleFonts.poppins(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get h2 => GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get h3 => GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get button => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );
}
