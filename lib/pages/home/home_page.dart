import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:school_erp/features/auth/bloc/auth_bloc_barrel.dart';
import 'package:school_erp/features/auth/auth_repository/auth_repository.dart';
import 'package:school_erp/pages/EnterExitRoute.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/assignment_list_page.dart';
import 'package:school_erp/pages/calendar/calendar_attendance_page.dart';
import 'package:school_erp/pages/change_password/change_password_page.dart';
import 'package:school_erp/pages/common_widgets/animation_widgets/loading_overlay.dart';
import 'package:school_erp/pages/events/events_page.dart';
import 'package:school_erp/pages/leave_application/leave_application_page.dart';
import 'package:school_erp/pages/profile/profile_page.dart';
import 'package:school_erp/pages/timetable/timetable_page.dart';
import 'package:school_erp/pages/ask_doubt/ask_doubt_page.dart';
import 'package:school_erp/pages/school_gallery/school_gallery_page.dart';
import 'widgets/navigation_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';
import 'package:school_erp/constants/text_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage(this.user, {super.key});

  final AuthenticatedUser user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget gridSection(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'title': 'Play Quiz', 'icon': Icons.quiz, 'callback': () => ()},
      {
        'title': 'Assignment',
        'icon': Icons.assignment,
        'callback': () {
          Navigator.push(
              context,
              EnterExitRoute(
                  exitPage: context.widget,
                  enterPage: const AssignmentListPage()));
        }
      },
      {
        'title': 'Calendar',
        'icon': Icons.calendar_today,
        'callback': () {
          Navigator.push(
            context,
            EnterExitRoute(
                exitPage: context.widget,
                enterPage: CalendarAttendancePage(focusDate: DateTime.now())),
          );
        }
      },
      {
        'title': 'Time Table',
        'icon': Icons.schedule,
        'callback': () {
          Navigator.push(
              context,
              EnterExitRoute(
                  exitPage: context.widget, enterPage: const TimeTablePage()));
        }
      },
      {
        'title': 'Doubts',
        'icon': Icons.help_outline,
        'callback': () {
          Navigator.push(
              context,
              EnterExitRoute(
                  exitPage: context.widget, enterPage: const AskDoubtPage()));
        }
      },
      {
        'title': 'School Gallery',
        'icon': Icons.photo_album,
        'callback': () {
          Navigator.push(
              context,
              EnterExitRoute(
                  exitPage: context.widget,
                  enterPage: const SchoolGalleryPage()));
        }
      },
      {
        'title': 'Leave Application',
        'icon': Icons.request_page,
        'callback': () {
          Navigator.push(
              context,
              EnterExitRoute(
                  exitPage: context.widget,
                  enterPage: const LeaveApplicationPage()));
        }
      },
      {
        'title': 'Change Password',
        'icon': Icons.lock,
        'callback': () {
          Navigator.push(
              context,
              EnterExitRoute(
                  exitPage: context.widget,
                  enterPage: const ChangePasswordPage()));
        }
      },
      {
        'title': 'Events',
        'icon': Icons.event,
        'callback': () {
          Navigator.push(
              context,
              EnterExitRoute(
                  exitPage: context.widget, enterPage: const EventsPage()));
        }
      },
      {
        'title': 'Logout',
        'icon': Icons.logout,
        'callback': () => context.read<AuthBloc>().add(LogoutRequested())
      },
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.2,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return NavigationCard(
          title: items[index]['title'],
          icon: items[index]['icon'],
          callback: items[index]['callback'],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              _buildMainContent(),
              _buildTopSection(),
              if (state is AuthLoading) const LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      margin: const EdgeInsets.only(top: 350),
      padding: const EdgeInsets.only(top: 130),
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      height: MediaQuery.of(context).size.height,
      child: gridSection(context),
    );
  }

  Widget _buildTopSection() {
    return Column(
      children: [
        profileInfo(widget.user),
        importantSection(),
      ],
    );
  }

  Widget profileInfo(AuthenticatedUser user) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = MediaQuery.of(context).size.width;
          bool isSmallScreen = screenWidth < 400;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 50.0),
                child: _buildUserInfo(user),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  right: isSmallScreen ? 16.0 : 30.0,
                  top: isSmallScreen ? 0.0 : 30.0,
                ),
                child: Align(
                  alignment:
                      isSmallScreen ? Alignment.topLeft : Alignment.bottomLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        EnterExitRoute(
                          exitPage: context.widget,
                          enterPage: const ProfilePage(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: isSmallScreen
                          ? 40
                          : 50, // Adjust the radius for small screens
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        size: isSmallScreen ? 60 : 90, // Adjust icon size
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserInfo(AuthenticatedUser user) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextConstants.homePageMessage(user.firstName, user.lastName),
            style: headingStyle()
                .copyWith(fontSize: 30.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8.0),
          Opacity(
            opacity: 0.7, // Set your desired opacity level here (0.0 to 1.0)
            child: Text(
              "Class XI-B | Roll no: 04",
              style: bodyStyle().copyWith(
                fontSize: 18.0,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            alignment: Alignment.topLeft,
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              "2024-2025",
              style: bodyStyle()
                  .copyWith(fontSize: 14.0, color: const Color(0xFF6184C7)),
            ),
          ),
        ],
      ),
    );
  }

  Widget importantSection() {
    final List<Map<String, dynamic>> importantItems = [
      {
        'title': 'PE',
        'value': 'TOP 2',
        'icon': Icons.school,
        'color': AppColors.warningColor,
        'onTap': () => print('Tapped top 2'),
      },
      {
        'title': 'Merit POints',
        'value': '999999',
        'icon': Icons.monetization_on,
        'color': AppColors.purple,
        'onTap': () => print('Tapped on second box'),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: GridView.builder(
        physics:
            const NeverScrollableScrollPhysics(), // To keep it non-scrollable
        shrinkWrap:
            true, // Ensures the grid view only takes the necessary space
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          mainAxisExtent: 256,
          childAspectRatio: 0.78,
        ),
        itemCount: importantItems.length,
        itemBuilder: (context, index) {
          final item = importantItems[index];
          return _buildImportantCard(
            title: item['title'],
            value: item['value'],
            icon: item['icon'],
            color: item['color'],
            onTap: item['onTap'],
          );
        },
      ),
    );
  }

  Widget _buildImportantCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double textSize = math.min(screenWidth * 0.1, 40.0); // Max size is 40
    double textSizeSm = math.min(screenWidth * 0.049, 24.0); // Max size is 24

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: AppColors.primaryColor, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35.0,
                    backgroundColor: color,
                    child: Icon(icon, size: 40.0, color: Colors.white),
                  ),
                  Text(
                    value,
                    style: headingStyle().copyWith(
                      fontSize: textSize,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    title,
                    style: bodyStyle().copyWith(fontSize: textSizeSm),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
