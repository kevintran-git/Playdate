import 'package:flutter/material.dart';
import 'dart:math';
import 'common.dart';

class ActivePlaydate extends StatefulWidget {
  final Playdate playdate;

  const ActivePlaydate({
    super.key,
    required this.playdate,
  });

  @override
  ActivePlaydateState createState() => ActivePlaydateState();
}

class ActivePlaydateState extends State<ActivePlaydate> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 20,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Deadline: in 3 days",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?q=80&w=1727&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                              radius: 11,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Playdate with Nicole S.",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    widget.playdate.location,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
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
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                // duration
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Duration: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.playdate.duration,
                        ),
                      ],
                    ),
                  ),
                ),
                // cost
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Cost: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.playdate.price.name,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Description: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.playdate.description,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: FilledButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: const Text('Playdate Completed'),
                              content: const Text(
                                  'Your playdate has been completed successfully.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // close the dialog
                                    Navigator.of(dialogContext).pop();
                                    // update the state
                                    setState(() {
                                      isVisible = false;
                                    });
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Complete!',
                          style: TextStyle(fontSize: 30)),
                    ),
                  ),
                )
              ],
            ),
          )
        : const Center(
            child: Text(
              "No active playdates!",
              style: TextStyle(fontSize: 30),
            ),
          );
  }
}

class ActivePlaydateTags extends StatefulWidget {
  final Playdate playdate;

  const ActivePlaydateTags({
    super.key,
    required this.playdate,
  });

  @override
  State<ActivePlaydateTags> createState() => _ActivePlaydateTagsState();
}

class _ActivePlaydateTagsState extends State<ActivePlaydateTags> {
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
          spacing: 8.0,
          children: [
            for (int j = i; j < min(i + 3, widget.playdate.tags.length); j++)
              Chip(
                  label: Text(widget.playdate.tags.elementAt(j),
                      style: const TextStyle(fontSize: 10)))
          ],
        ),
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Column(
            children: [
              Wrap(spacing: 8.0, children: tagChips),
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
      ],
    );
  }
}
