import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/action_button.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/add_item_button.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/multiple_choice/multiple_choice_answer_modal.dart';
import 'package:school_erp/pages/common_widgets/custom_snackbar.dart';

class MultipleChoiceContent extends StatefulWidget {
  final TextEditingController questionController;
  const MultipleChoiceContent({super.key, required this.questionController});

  @override
  _MultipleChoiceContentState createState() => _MultipleChoiceContentState();
}

class _MultipleChoiceContentState extends State<MultipleChoiceContent> {
  final List<String> _choices = ['', '', '', ''];
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controllers
        .addAll(_choices.map((choice) => TextEditingController(text: choice)));
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addChoice() {
    setState(() {
      _choices.add('');
      _controllers.add(TextEditingController());
    });
  }

  void _removeChoice(int index) {
    if (_choices.length > 1) {
      setState(() {
        _choices.removeAt(index);
        _controllers[index].dispose();
        _controllers.removeAt(index);
      });
    }
  }

  void _clearChoice(int index) {
    setState(() {
      _controllers[index].clear();
      _choices[index] = '';
    });
  }

  void _updateChoice(int index, String value) {
    setState(() {
      _choices[index] = value;
    });
  }

  void _showAnswerModal() {
    List<String> nonEmptyChoices =
        _choices.where((choice) => choice.isNotEmpty).toList();

    if (widget.questionController.text.isEmpty) {
      showCustomSnackbar(context, 'No Question Provided');
      return;
    } else if (nonEmptyChoices.isEmpty) {
      showCustomSnackbar(
        context,
        'Please add at least one choice before providing an answer.',
      );
      return;
    }

    final modal = MultipleChoiceAnswerModal(
      context: context,
      choices: nonEmptyChoices,
    );
    modal.show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _choices.length,
            itemBuilder: (context, idx) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controllers[idx],
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Choice ${String.fromCharCode(65 + idx)}',
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => _clearChoice(idx),
                          ),
                        ),
                        onChanged: (value) => _updateChoice(idx, value),
                      ),
                    ),
                    const SizedBox(width: 8),
                    AddItemButton(
                      index: idx,
                      onAddPressed: _addChoice,
                      onRemovePressed: () => _removeChoice(idx),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        ActionButton(onPressed: _showAnswerModal, text: "Next"),
      ],
    );
  }
}

void showCustomSnackbar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => CustomSnackbar(message: message),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3)).then((_) {
    overlayEntry.remove();
  });
}
