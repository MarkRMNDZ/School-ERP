import 'package:flutter/material.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';

class AppBarAddButton extends StatelessWidget {
  final Widget exitPage;
  final Widget enterPage;

  const AppBarAddButton(
      {super.key, required this.exitPage, required this.enterPage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        createSlideRoute(enterPage),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.lightGreen[400],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
