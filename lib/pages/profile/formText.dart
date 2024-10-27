import 'package:flutter/material.dart';
import 'dart:math';

class FormText extends StatelessWidget {
  final double width;
  final double height;
  final String label;
  final String value;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Icon? icon; 

  const FormText({
    super.key,
    required this.width,
    required this.height,
    required this.label,
    required this.value,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.icon, 
  });

  @override
  Widget build(BuildContext context) {
   
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = min(screenWidth * 0.04, 18.0); // Set maximum font size to 18

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: min(fontSize * 0.9, 16.0), 
              ),
              softWrap: true,
              overflow: TextOverflow.ellipsis, 
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize, 
                      ),
                      maxLines: 2, 
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, 
                    ),
                  ),
                  if (icon != null) 
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: icon!,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
