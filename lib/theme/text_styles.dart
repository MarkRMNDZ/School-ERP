import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

TextStyle headingStyle() {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'SourceSans',
    color: AppColors.primaryFontColor,
    fontSize: 20.0,
  );
}

TextStyle bodyStyle() {
  return const TextStyle(
    fontFamily: 'SourceSans',
    color: AppColors.primaryFontColor,
    fontSize: 16.0,
  );
}

TextStyle buttonTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: 'SourceSans',
    color: AppColors.primaryFontColor,
    fontSize: 16.0,
  );
}

