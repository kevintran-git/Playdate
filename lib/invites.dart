import 'package:flutter/material.dart';
import 'package:playdate/common.dart';
import 'package:playdate/sampledata.dart';
import 'package:playdate/sentplaydate.dart';

class InviteInbox extends StatelessWidget {
  const InviteInbox({super.key});

  @override
  Widget build(BuildContext context) {
    final recievedPlaydates = examplePlaydates.getRange(0, 5);
    final pendingPlaydates = examplePlaydates.getRange(7, 9);
    final sentPlaydates = examplePlaydates.getRange(11, 13);

    List<Widget> recievedCards = [];
    for (final playdate in recievedPlaydates) {
      recievedCards.add(
          createCarouselWidget(playdate.title, playdate.imageUrl, context, () {
        showDialog(
          context: context,
          builder: ((BuildContext context) => SingleChildScrollView(
                child: Column(
                  children: [
                    ReceivedPlaydate(playdate: playdate),
                  ],
                ),
              )),
        );
      }));
    }

    List<Widget> pendingCards = [];
    for (final playdate in pendingPlaydates) {
      pendingCards.add(
          createCarouselWidget(playdate.title, playdate.imageUrl, context, () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Playdate Request"),
                  content:
                      const Text("Would you like to cancel this playdate?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Keep Playdate"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Playdate Cancelled"),
                                  content: const Text(
                                      "Your playdate has been cancelled successfully."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ));
                      },
                      child: const Text("Cancel Playdate"),
                    ),
                  ],
                ));
      }));
    }

    List<Widget> sentCards = [];
    for (final playdate in sentPlaydates) {
      sentCards.add(
          createCarouselWidget(playdate.title, playdate.imageUrl, context, () {
        showDialog(
          context: context,
          builder: ((BuildContext context) => SingleChildScrollView(
                child: Column(
                  children: [
                    SentPlaydate(playdate: playdate),
                  ],
                ),
              )),
        );
      }));
    }

    return Scaffold(
        appBar: getAppBar(context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed('/invite1');
          },
          label: const Text('New Invite'),
          icon: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(children: [
            // Invites in title
            makeTitle('Invites', true),
            // received invites in subtitle
            makeTitle('Received', false),
            // carousel of invites
            makeCarousel(recievedCards),
            // pending invites in subtitle
            makeTitle('Pending', false),
            // carousel of invites
            makeCarousel(pendingCards),
            // sent invites in subtitle
            makeTitle('Active Invites', false),
            // carousel of invites
            makeCarousel(sentCards),
          ]),
        ));
  }
}

// helper functio
