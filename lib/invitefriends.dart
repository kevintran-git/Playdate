import 'package:flutter/material.dart';

class InviteFriends extends StatelessWidget {
  const InviteFriends({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> playmates = [
      const PlaymateCheckbox(
          title: 'Kevin T.',
          imageUrl:
              'https://images.unsplash.com/photo-1607990281513-2c110a25bd8c?q=80&w=2707&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
      const PlaymateCheckbox(
          title: 'Nicole S.',
          imageUrl:
              'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?q=80&w=1727&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
      const PlaymateCheckbox(
          title: 'Sachin A.',
          imageUrl:
              'https://images.unsplash.com/photo-1603415526960-f7e0328c63b1?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
      const PlaymateCheckbox(
          title: 'Mena H.',
          imageUrl:
              'https://images.unsplash.com/photo-1474447976065-67d23accb1e3?q=80&w=1885&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')
    ];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Choose Playmates'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(children: [
            SearchAnchor.bar(
              barHintText: "Search Playmates",
              barLeading: const Icon(Icons.search),
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) => [],
            ),
            const SizedBox(
              height: 16,
            ),
            ...playmates,
            const SizedBox(
              height: 16,
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Write a message',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FilledButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: const Text('Invite Sent'),
                      content:
                          const Text('Your invite has been sent successfully.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName('/'));
                            Navigator.of(dialogContext)
                                .popUntil(ModalRoute.withName('/'));
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Send Invite'),
            ),
          ]),
        ));
  }
}

class PlaymateCheckbox extends StatefulWidget {
  const PlaymateCheckbox(
      {super.key, required this.title, required this.imageUrl});

  final String title;
  final String imageUrl;

  @override
  State<PlaymateCheckbox> createState() => PlaymateCheckboxState();
}

class PlaymateCheckboxState extends State<PlaymateCheckbox> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CheckboxListTile(
        title: Text(
          widget.title,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400), // Increase the font size to 18
        ),
        value: _checked,
        onChanged: (newValue) {
          setState(() {
            _checked = newValue!;
          });
        },
        secondary: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(widget.imageUrl),
        ),
      ),
    );
  }
}
