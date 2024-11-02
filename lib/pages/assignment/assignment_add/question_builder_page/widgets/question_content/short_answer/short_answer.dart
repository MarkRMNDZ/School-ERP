import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/action_button.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/add_item_button.dart';
import 'short_answer_modal.dart';

class ShortAnswerContent extends StatefulWidget {
  final TextEditingController questionController;
  const ShortAnswerContent({super.key, required this.questionController});

  @override
  _ShortAnswerContentState createState() => _ShortAnswerContentState();
}

class _ShortAnswerContentState extends State<ShortAnswerContent> {
  void _showAnswerModal() {
    final modal = ShortAnswerModal(
      context,
      questionController: widget.questionController,
    );
    modal.show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        ActionButton(onPressed: _showAnswerModal, text: "Provide Answer"),
      ],
    );
  }
}

class AnswerField extends StatelessWidget {
  final TextEditingController controller;
  final int index;
  final VoidCallback onAddPressed;
  final VoidCallback onRemovePressed;
  final VoidCallback onClearPressed;

  const AnswerField({
    super.key,
    required this.controller,
    required this.index,
    required this.onAddPressed,
    required this.onRemovePressed,
    required this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
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
                  onPressed: onClearPressed,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          AddItemButton(
            index: index,
            onAddPressed: onAddPressed,
            onRemovePressed: onRemovePressed,
          ),
        ],
      ),
    );
  }
}
