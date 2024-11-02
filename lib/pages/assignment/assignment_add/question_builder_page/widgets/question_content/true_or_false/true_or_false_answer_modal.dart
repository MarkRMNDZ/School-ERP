import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/action_button.dart';
import 'package:school_erp/pages/common_widgets/common_modal.dart';
import 'package:flutter/material.dart';

class TrueOrFalseAnswerModal extends StatefulModal {
  static const List<String> trueFalseChoices = ['True', 'False'];

  TrueOrFalseAnswerModal(BuildContext context)
      : super(
          context: context,
          title: '',
          contentBuilder: (BuildContext context, StateSetter setState) {
            return _buildContent(context, setState);
          },
          actionsBuilder: (BuildContext context, StateSetter setState) {
            return _buildActions(context, setState);
          },
        );

  static String _selectedAnswer = 'True';

  static Widget _buildContent(BuildContext context, StateSetter setState) {
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
      items: trueFalseChoices.map<DropdownMenuItem<String>>((String value) {
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
