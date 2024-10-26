import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const DefaultButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    Color darkerColor = HSLColor.fromColor(AppColors.primaryColor)
        .withLightness(
            (HSLColor.fromColor(AppColors.primaryColor).lightness - 0.1)
                .clamp(0.0, 1.0))
        .toColor();

    return Container(
      width: double.infinity, // Makes the button expand to full width
      height: 50, // Fixed height for the button
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, darkerColor], // Blue gradient
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600, // Semi-bold text
          ),
        ),
      ),
    );
  }
}
