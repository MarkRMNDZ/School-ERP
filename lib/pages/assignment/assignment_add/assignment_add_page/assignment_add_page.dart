import 'package:flutter/material.dart';
import 'widgets/add_assignment_form.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';

class AssignmentAddPage extends StatelessWidget {
  const AssignmentAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
        title: "Add Assignment", content: [AddAssignmentForm()]);
  }
}
