import 'package:flutter/material.dart';
import 'package:playdate/common.dart';
import 'package:playdate/sampledata.dart';
import 'explorepost.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  // Toggle state for showing or hiding filters
  bool _showFilters = false;
  // Toggle state for expanding or collapsing the tag list
  bool _showMoreTags = false;

  final Set<String> _selectedTags = <String>{};

  final Set<String> _tags = {
    'Hiking',
    'Picnic',
    'Food',
    'Tech',
    'Competition',
    'Culture',
    'Wellness',
    'Race',
    'Reading',
    'Music',
    'Fine Dining',
    'Sailing',
    'Experience',
    'Cultural',
    'Entertainment',
    'Snow',
    'Speed',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchAnchor.bar(
              barHintText: "Search for Playdates",
              barLeading: const Icon(Icons.search),
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) =>
                      examplePlaydates
                          .where((playdate) =>
                              playdate.title
                                  .toLowerCase()
                                  .contains(controller.text.toLowerCase()) ||
                              playdate.location
                                  .toLowerCase()
                                  .contains(controller.text.toLowerCase()))
                          .map((playdate) => ExplorePost(playdate: playdate))
                          .toList(),
            ),
          ),
          // Filter Selector
          GestureDetector(
            onTap: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _showFilters ? 'Apply filters' : 'Show filters',
                  ),
                  Icon(
                    _showFilters
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _showFilters ? (_showMoreTags ? 430 : 180) : 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Price',
                    ),
                    (_showFilters ? const PriceRangeSlider() : Container()),
                    const Text(
                      'Playtags',
                    ),
                    Wrap(
                      spacing: 8.0,
                      children:
                          (_showMoreTags ? _tags : _tags.take(4)).map((tag) {
                        return ChoiceChip(
                          label: Text(tag),
                          selected: _selectedTags.contains(tag),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                _selectedTags.add(tag);
                              } else {
                                _selectedTags.remove(tag);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    if (_showFilters)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _showMoreTags = !_showMoreTags;
                          });
                        },
                        child: Text(_showMoreTags ? 'Less' : 'More'),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // End Filter Selector
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(children: [
                  ...(examplePlaydates
                      .where((playdate) =>
                          playdate.tags
                              .intersection(_selectedTags)
                              .isNotEmpty ||
                          _selectedTags.isEmpty)
                      .map((playdate) => ExplorePost(playdate: playdate))
                      .toList()),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
