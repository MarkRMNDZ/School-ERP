import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';
import 'package:school_erp/pages/timetable/widget/timetable_tabbar.dart';
import 'package:school_erp/theme/colors.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/pages/timetable/widget/timetable_card.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({super.key});

  @override
  _TimeTablePageState createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> with TickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? timetableData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _loadTimetable();
  }


  Future<void> _loadTimetable() async {
    final String response = await rootBundle.loadString('assets/timetable.json');
    setState(() {
      timetableData = json.decode(response);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTabContent(String day) {
    if (timetableData == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final subjects = List<Map<String, dynamic>>.from(timetableData!['timetable'][day]);
    return TimetableCard(day: day, subjects: subjects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const CustomAppBar(title: 'Timetable'),
          AppContent(
            content: [
              const SizedBox(height: 25),
              TimeTableTabBar(controller: _tabController),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTabContent('Monday'),
                    _buildTabContent('Tuesday'),
                    _buildTabContent('Wednesday'),
                    _buildTabContent('Thursday'),
                    _buildTabContent('Friday'),
                    _buildTabContent('Saturday'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
