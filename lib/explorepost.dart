import 'package:flutter/material.dart';
import 'package:playdate/sampledata.dart';
import 'dart:math';
import 'common.dart';

class ExplorePost extends StatefulWidget {
  final Playdate playdate;

  const ExplorePost({
    super.key,
    required this.playdate,
  });

  @override
  ExplorePostState createState() => ExplorePostState();
}

class ExplorePostState extends State<ExplorePost> {
  bool isSaved = false;
  bool showAllTags = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> tagChips = [];
    for (int i = 0; i < (min(3, widget.playdate.tags.length)); i++) {
      tagChips.add(Chip(
          label: Text(widget.playdate.tags.elementAt(i),
              style: const TextStyle(fontSize: 10))));
    }

    List<Widget> additionalTags = [
      // one row for every 3 tags
      for (int i = 3; i < widget.playdate.tags.length; i += 3)
        Wrap(
          spacing: 4.0,
          children: [
            for (int j = i; j < min(i + 3, widget.playdate.tags.length); j++)
              Chip(
                  label: Text(widget.playdate.tags.elementAt(j),
                      style: const TextStyle(fontSize: 10)))
          ],
        ),
    ];

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    // Display the chips
                    Wrap(spacing: 4.0, children: tagChips),
                    const Spacer(), // Push the icons to the end of the row
                    IconButton(
                      // save button
                      icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border),
                      iconSize: 30,
                      onPressed: () => setState(() => isSaved = !isSaved),
                    ),
                    IconButton(
                      // share button
                      icon: const Icon(Icons.send),
                      iconSize: 30,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/invite2');
                      },
                    ),
                  ],
                ),
                if (showAllTags)
                  Align(
                      alignment: Alignment.topLeft,
                      child: Column(children: additionalTags)),
              ],
            ),
          ),
          if (widget.playdate.tags.length > 3)
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  showAllTags ? 'Show less' : 'Show all',
                ),
              ),
              onTap: () {
                setState(() {
                  showAllTags = !showAllTags;
                });
              },
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              widget.playdate.location,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Semantics(
            label: widget.playdate.imageAltText,
            child: Image.network(
              widget.playdate.imageUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.playdate.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${widget.playdate.author} ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: widget.playdate.description,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
            child: Text(
              '${widget.playdate.comments.length} comments',
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(exampleProfilePicture)),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      hintStyle: TextStyle(fontSize: 14),
                      isDense: true, // Needed to reduce the size
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
