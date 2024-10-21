import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_erp/pages/profile/formText.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';

class FormTextData {
  final String label;
  final String value;
  final IconData? icon;
  final double width;

  FormTextData(this.label, this.value, [this.icon, this.width = 175]);
}

class MyIcons {
  static const IconData cameraAltOutlined =
      IconData(0xef1e, fontFamily: 'MaterialIcons');
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          CustomAppBar(
            title: 'My Profile',
            trailingWidget: TextButton.icon(
              onPressed: () {
                print('Done button pressed');
              },
              icon: const Icon(
                Icons.check,
                color: AppColors.primaryColor,
              ),
              label: const Text(
                'Done',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
            ),
          ),
          AppContent(
            content: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  profileCard(),
                  SingleChildScrollView(child: profileForm())
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget profileCard() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: AppColors.primaryColor, width: 2.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                 const Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(top:15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Akshay Syal',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Class XI-B | Roll no: 04',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child:  Padding(
                      padding: EdgeInsets.only(top:15.0),
                      child: Icon(
                        MyIcons.cameraAltOutlined,
                        size: 23,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget profileForm() {
    final List<List<FormTextData>> formTextDataList = [
      [
        FormTextData('Adhar No.', '1234 4325 4567 1234'),
        FormTextData('Academic Year', '2020 - 2021'),
      ],
      [
        FormTextData('Admission Class', 'VI', CupertinoIcons.lock_fill),
        FormTextData('Old Admission No.', 'T00221', CupertinoIcons.lock_fill),
      ],
      [
        FormTextData(
            'Date of Admission', '01 Apr 2018', CupertinoIcons.lock_fill),
        FormTextData('Date of Birth', '22 July 1996', CupertinoIcons.lock_fill),
      ],
      [
        FormTextData('Parent Mail ID', 'parentboth84@gmail.com',
            CupertinoIcons.lock_fill, 370),
      ],
      [
        FormTextData(
            'Mother Name', 'Monica Larson', CupertinoIcons.lock_fill, 370),
      ],
      [
        FormTextData(
            'Father Nme', 'Bernard Taylor', CupertinoIcons.lock_fill, 370),
      ],
      [
        FormTextData('Permanent Add', 'Karol Bagh, Delhi',
            CupertinoIcons.lock_fill, 370),
      ],
    ];

    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: formTextDataList.length,
        itemBuilder: (context, index) {
          return buildFormRow(formTextDataList[index]);
        },
      ),
    );
  }

  Widget buildFormRow(List<FormTextData> data) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: data.map((item) {
          return Expanded(
            child: FormText(
              width: item.width,
              height: 75,
              label: item.label,
              value: item.value,
              icon: item.icon != null
                  ? Icon(item.icon, size: 22.0, color: Colors.grey)
                  : null,
            ),
          );
        }).toList(),
      ),
    );
  }
}
