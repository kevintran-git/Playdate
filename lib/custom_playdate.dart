import 'package:flutter/material.dart';
import 'package:playdate/common.dart';

class CreatePlaydateScreen extends StatefulWidget {
  const CreatePlaydateScreen({super.key});

  @override
  _CreatePlaydateScreenState createState() => _CreatePlaydateScreenState();
}

class _CreatePlaydateScreenState extends State<CreatePlaydateScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String? _duration;
  String? _durationUnit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text('Create Custom Playdate'),
              ),
              makeTitle("Title", false),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'What is the name of your playdate?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              makeTitle("Description", false),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'What are the details of your playdate?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              makeTitle("Price", false),
              const SizedBox(
                height: 8,
              ),
              const PriceRangeSlider(),
              const SizedBox(
                height: 16,
              ),
              makeTitle("Location", false),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Where will your playdate be?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              makeTitle("Duration", false),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    DropdownButton<String>(
                      value: _duration,
                      hint: const Text('Number'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _duration = newValue;
                        });
                      },
                      items: <String>[
                        '1',
                        '2',
                        '3',
                        '4',
                        '5',
                        '6',
                        '7',
                        '8',
                        '9',
                        '10'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    DropdownButton<String>(
                      value: _durationUnit,
                      hint: const Text('Time Unit'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _durationUnit = newValue;
                        });
                      },
                      items: <String>[
                        'minute(s)',
                        'hour(s)',
                        'day(s)',
                        'week(s)'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              makeTitle("Media", false),
              const SizedBox(
                height: 8,
              ),
              createAddButton(context, 'Add Media'),
              const SizedBox(
                height: 32,
              ),
              FilledButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: const Text('Playdate Created'),
                        content: const Text(
                            'You have created a playdate successfully!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                              Navigator.of(context).pushNamed('/invite2');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Create!', style: TextStyle(fontSize: 30)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
