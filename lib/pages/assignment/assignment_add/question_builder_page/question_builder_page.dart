import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/pages/login/widgets/rounded_container.dart';
import 'package:school_erp/theme/colors.dart';
import './widgets/widgets.dart';
import 'question_type.dart';

class QuestionBuilderPage extends StatelessWidget {
  const QuestionBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Question"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: const Material(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: RoundedContainer(
                  borderRadius: 30.0,
                  child: PaginatedFormContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaginatedFormContent extends StatefulWidget {
  const PaginatedFormContent({
    super.key,
  });

  @override
  _FormContentState createState() => _FormContentState();
}

class _FormContentState extends State<PaginatedFormContent> {
  QuestionType _questionType = QuestionType.multipleChoice;
  final TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        QuestionTypeSection(
          questionType: _questionType,
          onQuestionTypeChanged: (QuestionType? newValue) {
            setState(() {
              _questionType = newValue!;
            });
          },
        ),
        Question(questionController: _questionController),
        QuestionBody(
          questionController: _questionController,
          questionType: _questionType,
        ),
        const PaginationUI(),
      ],
    );
  }
}

//TODO: the pagination ui is temporary with no functionality yet, to be finished after connecting data
class PaginationUI extends StatelessWidget {
  const PaginationUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {},
        ),
        for (int i = 1; i <= 3; i++) PageNumber(pageNumber: i),
        const Text('...'),
        const PageNumber(pageNumber: 20),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {},
        ),
      ],
    );
  }
}

class PageNumber extends StatelessWidget {
  final int pageNumber;

  const PageNumber({super.key, required this.pageNumber});

  @override
  Widget build(BuildContext context) {
    bool isCurrentPage = pageNumber == 1;
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isCurrentPage ? AppColors.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          pageNumber.toString(),
          style: TextStyle(
            color: isCurrentPage ? Colors.white : Colors.black,
            fontWeight: isCurrentPage ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
