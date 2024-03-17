import 'package:flutter/material.dart';

class Applicant {
  final String title;
  final String description;
  final List<String> tags;

  Applicant({
    required this.title,
    required this.description,
    required this.tags,
  });
}

class ApplicantsPage extends StatefulWidget {
  const ApplicantsPage({super.key});

  @override
  _ApplicantsPageState createState() => _ApplicantsPageState();
}

class _ApplicantsPageState extends State<ApplicantsPage> {
  List<Applicant> applicants = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: applicants.length,
        itemBuilder: (context, index) {
          final applicant = applicants[index];
          return ListTile(
            title: Text(applicant.title),
            subtitle: Text(applicant.description),
            trailing: Wrap(
              spacing: 8.0,
              children:
                  applicant.tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddApplicantDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddApplicantDialog(BuildContext context) {
    String title = '';
    String description = '';
    List<String> tags = [];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Job Applicant'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  description = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Tags'),
                onChanged: (value) {
                  tags = value.split(',').map((tag) => tag.trim()).toList();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final applicant = Applicant(
                  title: title,
                  description: description,
                  tags: tags,
                );
                setState(() {
                  applicants.add(applicant);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
