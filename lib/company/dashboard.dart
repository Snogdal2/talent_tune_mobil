import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../shared_state.dart';

class Applicant {
  final String title;
  final String description;
  final List<dynamic> tags;

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

  @override
  void initState() {
    super.initState();
    getApplications();
  }
  List<dynamic> temp2 = [];
  List<Applicant> applicants = [];

  Future<String> getApplications() async {
    final token = SharedState.bearerToken();
    final joblistingResponse = await http.get(
      Uri.parse('http://localhost:3001/companies'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (joblistingResponse.statusCode == 200) {
      var temp = jsonDecode(joblistingResponse.body) as Map<String, dynamic>;
      temp2 = temp['data'][0]['jobListings'] as List<dynamic>;

      for (temp in temp2) {
        applicants.add(Applicant(
            title: temp['title'],
            description: temp['company'],
            tags: temp['tags']
        ));
      }
      setState(() {});
      return "true";
    } else {
      // If the profile request failed,
      // then throw an exception.
      throw Exception('Failed to get user profile.');
    }
  }

  Future<String> createApplications(
      title, description, List<String> tags) async {
    final token = SharedState.bearerToken();
    final Chatgpt = await http.post(
      Uri.parse('http://localhost:3001/job-listings'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
          {'title': title, 'description': description, 'tags': tags}),
    );
    if (Chatgpt.statusCode == 201) {
      return '';
    } else {
      // If the profile request failed,
      // then throw an exception.
      throw Exception('Failed to get user profile.');
    }
  }

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
              children: [
                ...applicant.tags.map((tag) => Chip(label: Text(tag))).toList(),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    //_deleteApplicant(index);
                  },
                ),
              ],
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
                createApplications(title, description, tags);
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