import 'package:flutter/material.dart';
import 'package:school_erp/constants/text_constants.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/theme/text_styles.dart';

class DashboardHeader extends StatelessWidget {
  final AuthenticatedUser user;

  const DashboardHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _userInfo(context, user),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _userInfo(BuildContext context, AuthenticatedUser user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  TextConstants.studentName(user.firstName, user.lastName),
                  style: headingStyle().copyWith(fontSize: 20),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: const Text(
                  'Grade 8 | Sampaguita',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              createSlideRoute(NotificationWidget(user: user)),
            );
          },
          child: const Icon(
            Icons.notifications,
            size: 32,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final AuthenticatedUser user;

  const NotificationWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: const Icon(Icons.notifications_sharp),
                title: const Text('Notification 1'),
                subtitle: const Text('This is a notification'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.notifications_sharp),
                title: const Text('Notification 2'),
                subtitle: const Text('This is a notification'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
