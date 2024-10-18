import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/pages/EnterExitRoute.dart';
import 'package:school_erp/pages/assignment/assignment_preview/assignment_preview_page.dart';
import 'package:school_erp/pages/common_widgets/default_button.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';
import 'package:school_erp/theme/colors.dart';

class AssignmentCard extends StatelessWidget {
  final Assessment assessment;

  const AssignmentCard(this.assessment, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          EnterExitRoute(
            exitPage: context.widget,
            enterPage: const AssignmentPreviewPage(),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      assessment.subject.capitalize(),
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    assessment.title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Start Date: ${DateFormat('yyyy-MM-dd HH:mm').format(assessment.startTime)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    'Submission Date: ${DateFormat('yyyy-MM-dd HH:mm').format(assessment.deadLine)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: DefaultButton(
                      text: assessment.status.displayName,
                      onPressed: () => (),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.grey),
                onPressed: () {
                  Navigator.push(
                    context,
                    EnterExitRoute(
                      exitPage: context.widget,
                      enterPage: const AssignmentPreviewPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
