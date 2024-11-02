import 'package:flutter/material.dart';
import 'package:school_erp/theme/text_styles.dart';

typedef ModalContentBuilder = Widget Function(
  BuildContext context,
  StateSetter setState,
);

typedef ModalActionsBuilder = List<Widget> Function(
  BuildContext context,
  StateSetter setState,
);

class StatefulModal {
  final BuildContext context;
  final String title;
  final ModalContentBuilder contentBuilder;
  final ModalActionsBuilder actionsBuilder;
  final bool barrierDismissible;

  StatefulModal({
    required this.context,
    required this.title,
    required this.contentBuilder,
    required this.actionsBuilder,
    this.barrierDismissible = true,
  });

  void show() {
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(title,
                  style: headingStyle().copyWith(color: Colors.black)),
              content: SingleChildScrollView(
                child: contentBuilder(context, setState),
              ),
              actions: actionsBuilder(context, setState),
            );
          },
        );
      },
    );
  }
}

class StatelessModal {
  final BuildContext context;
  final String title;
  final Widget content;
  List<Widget>? actions;
  final bool barrierDismissible;

  StatelessModal({
    required this.context,
    required this.title,
    required this.content,
    this.actions,
    this.barrierDismissible = true,
  });

  void show() {
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(title, style: headingStyle().copyWith(color: Colors.black)),
          content: SingleChildScrollView(
            child: content,
          ),
          actions: actions ??
              [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok'),
                ),
              ],
        );
      },
    );
  }
}
