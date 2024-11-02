import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/pages/common_widgets/app_bar_widgets/sql_console.dart';
import 'package:school_erp/theme/text_styles.dart';
import 'package:school_erp/utils/sql_statements.dart';
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
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: SizedBox(
          height: 56.0,
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  iconSize: 25,
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: onBackPressed ?? () => Navigator.pop(context),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      title,
                      style: titleStyle ??
                          headingStyle()
                              .copyWith(fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ),
              if (kDebugMode)
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    createSlideRoute(
                      Scaffold(
                        appBar: AppBar(
                          title: const Text('SQL Console'),
                        ),
                        body: const QueryWidget(
                            defaultQuery: defaultSqlConsoleQuery),
                      ),
                    ),
                  ),
                  child: const Text(
                    '{ }',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
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
