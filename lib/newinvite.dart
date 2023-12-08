import 'package:flutter/material.dart';
import 'package:playdate/common.dart';
import 'package:playdate/sampledata.dart';

class NewInvitePlaydate extends StatelessWidget {
  const NewInvitePlaydate({super.key});

  @override
  Widget build(BuildContext context) {
    final savedPlaydates = examplePlaydates.getRange(0, 5);
    final customPlaydates = examplePlaydates.getRange(6, 7);

    List<Widget> savedCards = [];
    for (final playdate in savedPlaydates) {
      savedCards.add(
          createCarouselWidget(playdate.title, playdate.imageUrl, context, () {
        Navigator.of(context).pushNamed('/invite2');
      }));
    }
    
    List<Widget> customCards = [];

    for (final playdate in customPlaydates) {
      customCards.add(
          createCarouselWidget(playdate.title, playdate.imageUrl, context, () {
        Navigator.of(context).pushNamed('/invite2');
      }));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Choose Playdate'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SearchAnchor.bar(
                barHintText: "Search for Playdates",
                barLeading: const Icon(Icons.search),
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) => [],
              ),
            ),
            makeTitle('Custom Playdates', false),
            // carousel of invites
            makeCarousel([
              const NewPlaydateButton(),
              ...customCards,
            ]),
            // pending invites in subtitle
            makeTitle('Saved Playdates', false),
            makeCarousel(savedCards),
          ]),
        ));
  }
}

class NewPlaydateButton extends StatelessWidget {
  const NewPlaydateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/custom_playdate');
      },
      child: createAddButton(context, 'Add New')
    );
  }
}

