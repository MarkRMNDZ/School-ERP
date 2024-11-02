import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({super.key, required this.user});

  final AuthenticatedUser user;

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  final List<String> _messages = ['Hi!', 'Hello', 'How are you?'];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.insert(0, _controller.text); // Insert new message at the top
        _controller.clear(); // Clear the input field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Contacts Section (optional, can be removed if not needed)
        Container(
          padding: const EdgeInsets.all(8.0),
          color: AppColors.greyColor,
          child: Text(
            'Contacts',
            style: bodyStyle().copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // Chat Messages Section
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: _messages.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildMessageContainer(_messages[index], index % 2 == 0);
            },
          ),
        ),

        // Input Message Field
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: AppColors.greyColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.send, color: AppColors.primaryColor),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageContainer(String message, bool isSender) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSender ? AppColors.primaryColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message,
          style: bodyStyle().copyWith(
            color: isSender ? AppColors.whiteColor : AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
