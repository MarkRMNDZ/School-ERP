import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/action_button.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/add_item_button.dart';
import 'package:school_erp/pages/common_widgets/common_modal.dart';
import 'package:flutter/material.dart';

class ShortAnswerModal extends StatefulModal {
  final TextEditingController questionController;
  static final List<TextEditingController> _answerControllers = [
    TextEditingController()
  ];

  ShortAnswerModal(
    BuildContext context, {
    required this.questionController,
  }) : super(
          context: context,
          title: 'Acceptable Answers',
          contentBuilder: (BuildContext context, StateSetter setState) {
            return _buildContent(context, setState);
          },
          actionsBuilder: (BuildContext context, StateSetter setState) {
            return _buildActions(context, setState);
          },
        );

  static Widget _buildContent(BuildContext context, StateSetter setState) {
    return SizedBox(
      width: double.maxFinite,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _answerControllers.length,
        itemBuilder: (context, index) => _buildAnswerField(
          context,
          setState,
          _answerControllers[index],
          index,
        ),
      ),
    );
  }

  static Widget _buildAnswerField(
    BuildContext context,
    StateSetter setState,
    TextEditingController controller,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Answer ${index + 1}",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _clearAnswerField(setState, index),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          AddItemButton(
            index: index,
            onAddPressed: () => _addAnswerField(setState),
            onRemovePressed: () => _removeAnswerField(setState, index),
          ),
        ],
      ),
    );
  }

  static void _addAnswerField(StateSetter setState) {
    setState(() {
      _answerControllers.add(TextEditingController());
    });
  }

  static void _removeAnswerField(StateSetter setState, int index) {
    if (_answerControllers.length > 1) {
      setState(() {
        _answerControllers[index].dispose();
        _answerControllers.removeAt(index);
      });
    }
  }

  static void _clearAnswerField(StateSetter setState, int index) {
    setState(() {
      _answerControllers[index].clear();
    });
  }

  static List<Widget> _buildActions(
      BuildContext context, StateSetter setState) {
    return <Widget>[
      Center(
        child: ActionButton(
          onPressed: () {
            // Print answers for debugging
            for (int i = 0; i < _answerControllers.length; i++) {
              print('Answer ${i + 1}: ${_answerControllers[i].text}');
            }
            Navigator.of(context).pop();
            // TODO: add save logic + navigation
          },
          text: "Next",
        ),
      ),
    ];
  }
}
