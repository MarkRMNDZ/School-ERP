import 'package:flutter/material.dart';
import './app_bar_widgets/sync_status.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Widget? trailingWidget;
  final TextStyle? titleStyle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.trailingWidget,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 14.0, 16.0, 0.0),
        child: SizedBox(
          height: 56.0,
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  iconSize: 36,
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: onBackPressed ?? () => Navigator.pop(context),
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  style: titleStyle ??
                      const TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              ),
              const AppBarSyncStatus(),
              Align(alignment: Alignment.centerRight, child: trailingWidget),
            ],
          ),
        ),
      ),
    );
  }
}
