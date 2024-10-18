import 'package:flutter/material.dart';

// to be removed use  app content
class RoundedContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  const RoundedContainer({
    super.key,
    required this.child,
    this.borderRadius = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
        border: const Border(
          top: BorderSide(color: Colors.transparent, width: 2.0),
          left: BorderSide(color: Colors.transparent, width: 2.0),
          right: BorderSide(color: Colors.transparent, width: 2.0),
          bottom: BorderSide.none,
        ),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [child]),
    );
  }
}
