import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/action_button.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/true_or_false/true_or_false_answer_modal.dart';

class TrueFalseContent extends StatefulWidget {
  final TextEditingController questionController;
  const TrueFalseContent({super.key, required this.questionController});

  @override
  _TrueFalseContentState createState() => _TrueFalseContentState();
}

class _TrueFalseContentState extends State<TrueFalseContent> {
  void _showAnswerModal() {
    final modal = TrueOrFalseAnswerModal(context);
    modal.show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        ActionButton(onPressed: _showAnswerModal, text: "Next"),
      ],
    );
  }
}
