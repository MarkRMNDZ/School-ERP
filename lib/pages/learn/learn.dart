import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Learning',
      content: [
        Text(runtimeType.toString())
      ],
    );
  }
}
