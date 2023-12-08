import 'package:flutter/material.dart';
import 'package:playdate/common.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          // alignment
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            makeTitle("Account Details", false),
            const SizedBox(
              height: 8,
            ),
            // add indented text
            const Padding(
              padding: EdgeInsets.only(left: 36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Username: sachin",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Password: ********",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
