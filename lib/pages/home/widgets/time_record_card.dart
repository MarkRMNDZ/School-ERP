import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_erp/theme/text_styles.dart';
import 'package:school_erp/theme/colors.dart';

class TimeRecordWidget extends StatefulWidget {
  const TimeRecordWidget({super.key});

  @override
  _TimeRecordWidgetState createState() => _TimeRecordWidgetState();
}

class _TimeRecordWidgetState extends State<TimeRecordWidget> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  final String todayDate =
      "Today " + DateFormat('EEE, d MMM y').format(DateTime.now());

  // Function to pick time
  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          startTime = pickedTime;
        } else {
          endTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              todayDate,
              style: headingStyle().copyWith(fontSize: 18, color: Colors.black),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Start Time", style: TextStyle(fontSize: 14.0)),
                        Text(
                          "06:48",
                          style: TextStyle(
                              fontSize: 16.0, color: AppColors.successColor),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    width: 1,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.black,
                    thickness: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("End Time", style: TextStyle(fontSize: 14.0)),
                          Text(
                            "17:38",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            // Makes the button take full width
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            // Makes the button take full width
            child: ElevatedButton(
              onPressed: () => _selectTime(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                // Background color
                padding: const EdgeInsets.symmetric(vertical: 2),
                // Increase height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),
              child: Text("Record Time",
                  style: TextStyle(color: AppColors.whiteColor)),
            ),
          )
        ],
      ),
    );
  }
}
