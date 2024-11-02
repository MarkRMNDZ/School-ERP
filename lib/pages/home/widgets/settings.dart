import 'package:flutter/material.dart';
import 'package:school_erp/constants/urls.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/pages/ask_doubt/ask_doubt_page.dart';
import 'package:school_erp/pages/change_password/change_password_page.dart';
import 'package:school_erp/pages/home/widgets/logout_modal.dart';
import 'package:school_erp/pages/profile/profile_page.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart%20';
import 'package:url_launcher/url_launcher.dart';
class SettingWidget extends StatelessWidget {
  const SettingWidget({super.key, required this.user});

  Future<dynamic> _launchURL(String urlPost) async {
    final Uri url = Uri.parse(urlPost);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  final AuthenticatedUser user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: headingStyle().copyWith(color: AppColors.primaryColor),
                  ),
                  Divider(),
                  // Personal Settings
                  ListTile(
                    leading: Icon(Icons.person_outlined),
                    title: Text('My Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        createSlideRoute(ProfilePage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.domain_outlined),
                    title: Text('School Profile'),
                    onTap: () {
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('Change Password'),
                    onTap: () {
                      Navigator.push(
                        context,
                        createSlideRoute(ChangePasswordPage()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.light_mode_outlined),
                    title: Text('Light Mode'),
                    trailing: Switch(value: false, onChanged: (value) {
                      // Handle light mode toggle
                    }),
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: Text('Privacy Policy'),
                    onTap: () => _launchURL(UrlConstants.privacyPolicy),
                  ),
                  ListTile(
                    leading: Icon(Icons.headphones_outlined),
                    title: Text('Help and Support'),
                    onTap: () {
                      Navigator.push(
                        context,
                        createSlideRoute(AskDoubtPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_outlined),
                    title: Text('Logout'),
                    onTap: () => LogoutModal(context).show(),
                  ),
                  Divider(),
                  Center(
                    child: ListTile(
                      leading: Image.asset('assets/images/logo-text.png'),
                      title: Text('App Version'),
                      subtitle: Text('1.0.0'), // Replace with your app version
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}