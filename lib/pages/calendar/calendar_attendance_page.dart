import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:table_calendar/table_calendar.dart';
import './widgets/attendance_title.dart';
import 'package:intl/intl.dart';
import 'package:school_erp/theme/colors.dart';

class CalendarAttendancePage extends StatefulWidget {
  final DateTime focusDate;

  CalendarAttendancePage({super.key, DateTime? focusDate})
      : focusDate = focusDate ?? DateTime.now();

  @override
  _CalendarAttendancePageState createState() => _CalendarAttendancePageState();
}

class _CalendarAttendancePageState extends State<CalendarAttendancePage> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  String _selectedFilter = 'All';
  late List<DateTime> _daysInMonth;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = widget.focusDate;
    _daysInMonth = _getDaysInMonth(_focusedDay);
  }

  void _onMonthChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      _daysInMonth = _getDaysInMonth(focusedDay);
    });
  }

  List<DateTime> _getDaysInMonth(DateTime date) {
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    return List<DateTime>.generate(
      lastDayOfMonth.day,
      (index) => DateTime(date.year, date.month, index + 1),
    );
  }

  void _handleDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(title: 'Calendar', content: [
      CalendarWidget(
        focusedDay: _focusedDay,
        selectedDay: _selectedDay,
        onDaySelected: _handleDaySelected,
        onPageChanged: (focusedDay) {
          _onMonthChanged(focusedDay);
        },
      ),
      const SizedBox(height: 20.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 0),
              child: AttendanceTitle(),
            ),
            DropdownFilter(
              selectedFilter: _selectedFilter,
              onChanged: (newValue) {
                setState(() {
                  _selectedFilter = newValue!;
                });
              },
            ),
          ],
        ),
      ),
      AttendanceList(daysInMonth: _daysInMonth),
    ]);
  }
}

class CalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final void Function(DateTime, DateTime) onDaySelected;
  final ValueChanged<DateTime> onPageChanged;

  const CalendarWidget({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        focusedDay: focusedDay,
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2123, 12, 31),
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          onDaySelected(selectedDay, focusedDay);
        },
        headerStyle: const HeaderStyle(titleCentered: true),
        onPageChanged: (focusedDay) {
          onPageChanged(focusedDay);
        },
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        });
  }
}

class DropdownFilter extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String?> onChanged;

  const DropdownFilter({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedFilter,
      items: [
        _buildDropdownItem('All', Colors.white, Colors.grey),
        _buildDropdownItem('Absent', AppColors.dangerColor, Colors.transparent),
        _buildDropdownItem('Late', AppColors.warningColor, Colors.transparent),
        _buildDropdownItem(
            'Holiday', AppColors.successColor, Colors.transparent),
      ],
      onChanged: onChanged,
      underline: const SizedBox(),
    );
  }

  DropdownMenuItem<String> _buildDropdownItem(
      String label, Color color, Color borderColor) {
    return DropdownMenuItem<String>(
      value: label,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(color: borderColor),
            ),
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

class AttendanceList extends StatelessWidget {
  final List<DateTime> daysInMonth;

  const AttendanceList({
    super.key,
    required this.daysInMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: daysInMonth.length,
        itemBuilder: (context, index) {
          DateTime date = daysInMonth[index];
          String day = DateFormat('dd').format(date);
          String shortMonth = DateFormat('MMM').format(date);
          String weekday = DateFormat('EEEE').format(date);

          bool isHoliday = (weekday == "Saturday" || weekday == "Sunday");
          String status = isHoliday ? "Holiday" : "Present";

          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          day,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          shortMonth,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            status,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            weekday,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0),
                child: Divider(),
              ),
            ],
          );
        },
      ),
    );
  }
}
