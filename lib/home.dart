import 'package:flutter/material.dart';
import 'package:playdate/activeplaydate.dart';
import 'package:playdate/common.dart';
import 'package:playdate/sampledata.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/invite1');
        },
        label: const Text('New Invite'),
        icon: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ActivePlaydate(playdate: examplePlaydates.elementAt(0)),
            ],
          ),
        ),
      ),
    );
  }
}
