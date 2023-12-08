// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:playdate/common.dart';
import 'package:playdate/newinvite.dart';
import 'package:playdate/sampledata.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final username = 'Sachin A.';
  final amountOfPlaydates = 69;
  final amountOfPlaymates = 420;

  Widget buildProfileHeader(String username, String profilePictureUrl) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(profilePictureUrl),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          username,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var completedPlaydates = examplePlaydates.getRange(6, 11);
    List<Widget> completedCards = [];
    for (final playdate in completedPlaydates) {
      completedCards.add(createCarouselWidget(
          playdate.title, playdate.imageUrl, context, () {}));
    }

    final customPlaydates = examplePlaydates.getRange(6, 7);

    List<Widget> customCards = [];

    for (final playdate in customPlaydates) {
      customCards.add(createCarouselWidget(
          playdate.title, playdate.imageUrl, context, () {}));
    }

    List<Widget> savedCards = [];

    savedCards.add(createCarouselWidget(examplePlaydates[3].title,
        examplePlaydates[3].imageUrl, context, () {}));

    List<Widget> examplePlaymates = [
      buildProfileHeader("Kevin T",
          'https://images.unsplash.com/photo-1474447976065-67d23accb1e3?q=80&w=1885&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
      buildProfileHeader("Nicole S",
          'https://images.unsplash.com/photo-1474447976065-67d23accb1e3?q=80&w=1885&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
      buildProfileHeader("Mena H",
          'https://images.unsplash.com/photo-1474447976065-67d23accb1e3?q=80&w=1885&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
      buildProfileHeader("Will F",
          'https://images.unsplash.com/photo-1474447976065-67d23accb1e3?q=80&w=1885&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')
    ];

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildProfileHeader(username, exampleProfilePicture),
        Column(children: [
          Text(
            amountOfPlaydates.toString(),
          ),
          const Text(
            '  playdates',
          ),
        ]),
        Column(
          children: [
            Text(
              amountOfPlaymates.toString(),
            ),
            const Text(
              'playmates',
            ),
          ],
        ),
      ],
    );
    return Scaffold(
      appBar: getAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              header,
              makeTitle('Completed Playdates', false),
              makeCarousel(completedCards),
              makeTitle('Custom Playdates', false),
              // carousel of invites
              makeCarousel([
                const NewPlaydateButton(),
                ...customCards,
              ]),
              makeTitle('Saved Playdates', false),
              makeCarousel(savedCards),
              makeTitle('Playmates', false),
              makeCarousel(examplePlaymates)
            ],
          ),
        ),
      ),
    );
  }
}
