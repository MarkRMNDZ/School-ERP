import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/action_button.dart';
import 'package:school_erp/pages/common_widgets/common_modal.dart';

class MultipleChoiceAnswerModal extends StatefulModal {
  final List<String> choices;
  static String? _selectedAnswer;

  MultipleChoiceAnswerModal({
    required BuildContext context,
    required this.choices,
  }) : super(
          context: context,
          title: '',
          contentBuilder: (BuildContext context, StateSetter setState) {
            return _buildContent(context, setState, choices);
          },
          actionsBuilder: (BuildContext context, StateSetter setState) {
            return _buildActions(context, setState);
          },
        );

  static Widget _buildContent(
    BuildContext context,
    StateSetter setState,
    List<String> choices,
  ) {
    _selectedAnswer ??= choices.first;

    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: "Answer",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      value: _selectedAnswer,
      icon: const Icon(Icons.arrow_drop_down),
      isExpanded: true,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedAnswer = newValue;
          });
        }
      },
      items: choices.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  static List<Widget> _buildActions(
      BuildContext context, StateSetter setState) {
    return <Widget>[
      Center(
        child: ActionButton(
          onPressed: () {
            // TODO: Implement saving logic and navigation
          },
          text: "Next",
        ),
      ),
    ];
  }
}
