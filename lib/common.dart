import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:playdate/main.dart';
import 'package:provider/provider.dart';

enum PlaydatePrice {
  FREE,
  $,
  $$,
  $$$,
}

// create a data model class
class Playdate {
  final String location;
  final String title;
  final String author;
  final String description;
  final Set<String> tags;
  final List<String> comments;
  final String imageUrl;
  final String imageAltText;
  final PlaydatePrice price;
  final String duration;

  const Playdate({
    required this.location,
    required this.title,
    required this.author,
    required this.description,
    this.tags = const {},
    this.comments = const [],
    this.imageUrl = 'https://picsum.photos/250?image=9',
    this.imageAltText = 'Placeholder image',
    required this.price,
    required this.duration,
  });
}

AppBar getAppBar(BuildContext context) {
  return AppBar(
    title: GestureDetector(
      onTap: () {
        // Access provider and change the theme color
        Provider.of<ThemeProvider>(context, listen: false).cycleThemeColor();
      },
      child: Image.asset('assets/images/playdate_logo.png',
          fit: BoxFit.contain, height: 64),
    ),
    scrolledUnderElevation: 0.0,
    centerTitle: false,
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          Navigator.of(context).pushNamed('/settings');
        },
      ),
    ],
  );
}
// helper func to make title / subtitle from text
Widget makeTitle(String text, bool isTitle) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: isTitle ? 32 : 24,
                fontWeight: isTitle ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget createCarouselWidget(String inviteName, String inviteImage,
    BuildContext context, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      children: <Widget>[
        // The invite image
        Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(inviteImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // The white layer
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Theme.of(context)
                .colorScheme
                .background
                .withOpacity(0.5), // Adjust the opacity as needed
          ),
        ),
        // The invite title
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              inviteName, // Use the invite name here
              style: const TextStyle(
                fontSize: 20.0, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// helper fuc to make a carousel from invites
Widget makeCarousel(List<Widget> playdateWidgets) {
  return CarouselSlider(
    items: playdateWidgets,
    options: CarouselOptions(
        height: 130.0,
        enableInfiniteScroll: false,
        enlargeFactor: 0.2,
        enlargeCenterPage: true,
        viewportFraction: 0.4),
  );
}

Widget createAddButton(BuildContext context, String subtitle) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(8.0),
    ),
    width: 130,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const Icon(
          Icons.add,
          size: 90,
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

class PriceRangeSlider extends StatefulWidget {
  const PriceRangeSlider({super.key});

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  RangeValues _currentRangeValues = const RangeValues(0, 3);

  String _mapValueToString(double value) {
    switch (value.toInt()) {
      case 0:
        return 'Free';
      case 1:
        return '\$';
      case 2:
        return '\$\$';
      case 3:
        return '\$\$\$';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: _currentRangeValues,
      max: 3,
      divisions: 3,
      labels: RangeLabels(
        _mapValueToString(_currentRangeValues.start),
        _mapValueToString(_currentRangeValues.end),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
        });
      },
    );
  }
}
