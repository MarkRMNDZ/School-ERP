import 'package:flutter/material.dart';
import 'package:school_erp/theme/text_styles.dart';

class LeaveApplicationCard extends StatelessWidget {
  const LeaveApplicationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Class Teacher',
              labelStyle:
                  bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              hintText: '--',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
            style: bodyStyle().copyWith(fontSize: 18),
          ),
          const Divider(color: Color(0xFFA5A5A5)),
          const SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Application Title',
              labelStyle:
                  bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              hintText: '--',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
            style: bodyStyle().copyWith(fontSize: 18),
          ),
          const Divider(color: Color(0xFFA5A5A5)),
          const SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle:
                  bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              hintText: '--',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
            maxLines: 3,
            style: bodyStyle().copyWith(fontSize: 18),
          ),
          const Divider(color: Color(0xFFA5A5A5)),
          const SizedBox(height: 25),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5278C1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                print("Leave application sent");
              },
              child: Text(
                'SEND REQUEST',
                style: buttonTextStyle().copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
