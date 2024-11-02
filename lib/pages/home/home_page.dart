import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';
import 'package:school_erp/pages/home/widgets/dashboard_header.dart';
import 'package:school_erp/pages/home/widgets/features.dart';
import 'package:school_erp/pages/home/widgets/feeds.dart';
import 'package:school_erp/pages/home/widgets/message.dart';
import 'package:school_erp/pages/home/widgets/settings.dart';
import 'package:school_erp/pages/home/widgets/time_record_card.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage(this.user, {super.key});

  final AuthenticatedUser user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _navOnTap(int index) {
    setState(() {
      currentPageIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'St. Andrew Academy',
          style: headingStyle().copyWith(color: AppColors.primaryColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              'YR: 2024 - 2025',
              style: bodyStyle().copyWith(color: AppColors.primaryColor, fontSize: 12),
            ),
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        onDestinationSelected: _navOnTap,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.menu),
            icon: Icon(Icons.menu_rounded),
            label: 'Feeds',
          ),
          NavigationDestination(
            selectedIcon:Icon(Icons.messenger_sharp),
            icon: Icon(Icons.messenger_outline_sharp),
            label: 'Rooms',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Setting',
          ),
        ],
      ),
      backgroundColor: AppColors.primaryColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        children: [
          HomeWidget(user: widget.user),
          FeedsWidget(user: widget.user),
          ComingSoonWidget(),
          //MessageWidget(user: widget.user),
          SettingWidget(user: widget.user),
        ],
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key, required this.user});

  final AuthenticatedUser user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DashboardHeader(user: user),
                const SizedBox(height: 16),
                const TimeRecordWidget(),
              ],
            ),
          ),
          Expanded(child: Features(user: user)),
        ],
      ),
    );
  }
}

class ComingSoonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Chat rooms are under construction!!!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(height: 16),
          Image.asset(
            'assets/images/under_construction.webp',
          ),
          const SizedBox(height: 16),
          const Text(
            "Thank you for your patience! \n Stay tuned for what's coming soon!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

