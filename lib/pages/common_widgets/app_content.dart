import 'package:flutter/material.dart';

class AppContent extends StatelessWidget {
  final List<Widget> content;
  final bool isScrollable; // New parameter to control scrolling

  const AppContent({
    super.key,
    required this.content,
    this.isScrollable = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: isScrollable 
            ? SingleChildScrollView( // Use SingleChildScrollView if isScrollable is true
                child: Column(
                  children: content,
                ),
              )
            : Column(
                children: content,
              ),
      ),
    );
  }
}
