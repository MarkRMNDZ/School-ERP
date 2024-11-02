import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/enums/assessment_status.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/pages/assignment/assignment_preview/assignment_preview_page.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';
import 'package:school_erp/theme/text_styles.dart';

class AssignmentCard extends StatelessWidget {
  final Assessment assessment;

  const AssignmentCard({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  String getStatusText() => assessment.status.displayName;

  Color getStatusTextColor() {
    switch (assessment.status) {
      case AssessmentStatus.toBeCompleted:
        return Colors.blue;
      case AssessmentStatus.toBePublished:
        return Colors.orange;
      case AssessmentStatus.published:
        return const Color.fromARGB(255, 255, 255, 255);
      case AssessmentStatus.toFinishEvaluation:
        return Colors.yellow.shade700;
      case AssessmentStatus.finishedEvaluation:
        return Colors.grey.shade900;
    }
  }

  Color getStatusColor() {
    switch (assessment.status) {
      case AssessmentStatus.toBeCompleted:
        return Colors.lightBlue.shade50;
      case AssessmentStatus.toBePublished:
        return Colors.orange.shade100;
      case AssessmentStatus.published:
        return const Color.fromARGB(255, 0, 255, 8);
      case AssessmentStatus.toFinishEvaluation:
        return Colors.yellow.shade200;
      case AssessmentStatus.finishedEvaluation:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        createSlideRoute(const AssignmentPreviewPage()),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 3.2),
              _buildTitle(),
              const SizedBox(height: 7.8),
              _buildDates(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(assessment.subject.title(),
              style: headingStyle().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: getStatusColor(),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              getStatusText(),
              style: TextStyle(
                color: getStatusTextColor(),
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(assessment.title,
        style: headingStyle().copyWith(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black));
  }

  Widget _buildDates() {
    final startDate = DateFormat('dd MMM yy').format(assessment.startTime);
    final submissionDate = DateFormat('dd MMM yy').format(assessment.deadLine);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Assign Date: ',
              style: bodyStyle().copyWith(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            Text(
              startDate,
              style: headingStyle().copyWith(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 9.8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Last Submission Date: ',
              style: bodyStyle().copyWith(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            Text(
              submissionDate,
              style: headingStyle().copyWith(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
