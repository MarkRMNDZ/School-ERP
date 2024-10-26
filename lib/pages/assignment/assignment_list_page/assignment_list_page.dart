import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/pages/assignment/assignment_add/assignment_add_page/assignment_add_page.dart';
import 'package:school_erp/pages/common_widgets/app_bar_widgets/add_button.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'widgets/assignment_card.dart';
import 'package:school_erp/theme/colors.dart';

class AssignmentListPage extends StatefulWidget {
  const AssignmentListPage({super.key});

  @override
  _AssignmentListPageState createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage> {
  List<Assessment?> _data = [];
  late StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    final stream = Assessment.watchLists(AssessmentType.assignment);

    _subscription = stream.listen((data) {
      if (!context.mounted) {
        return;
      }
      setState(() {
        _data = data;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Assignment List',
            trailingWidget: AppBarAddButton(
                exitPage: widget, enterPage: const AssignmentAddPage()),
          ),
          AppContent(
            content: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: _data.map((assessment) {
                    return AssignmentCard(assessment!);
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
