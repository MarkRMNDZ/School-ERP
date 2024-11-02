import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/multiple_choice/multiple_choice.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/short_answer/short_answer.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/true_or_false/true_or_false.dart';
import 'question_content/essay.dart';
import '../question_type.dart';

class QuestionBody extends StatelessWidget {
  final QuestionType questionType;
  final TextEditingController questionController;

  const QuestionBody(
      {super.key,
      required this.questionType,
      required this.questionController});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Content(
            questionType: questionType, questionController: questionController),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final QuestionType questionType;
  final TextEditingController questionController;

  const Content(
      {super.key,
      required this.questionType,
      required this.questionController});

  @override
  Widget build(BuildContext context) {
    switch (questionType) {
      case QuestionType.multipleChoice:
        return MultipleChoiceContent(questionController: questionController);
      case QuestionType.shortAnswer:
        return ShortAnswerContent(questionController: questionController);
      case QuestionType.trueFalse:
        return TrueFalseContent(questionController: questionController);
      case QuestionType.essay:
        return EssayContent(questionController: questionController);
      default:
        return const SizedBox();
    }
  }
}
