import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../shared_state.dart';
import 'JobDetail.dart';

class JobListingPage extends StatefulWidget {
  const JobListingPage({super.key});

  @override
  _JobListingPageState createState() => _JobListingPageState();
}

class _JobListingPageState extends State<JobListingPage> {
  String searchQuery = '';
  List<dynamic> temp2 = [];
  List<JobListing> joblist = [];

  @override
  void initState() {
    super.initState();
    GetUserProfile();
  }

  Future<String> GetUserProfile() async {
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
        joblist.add(JobListing(
            title: temp['title'],
            company: temp['company'],
            tags: temp['tags'][0]));
      }
      setState(() {});
      return "true";
    } else {
      // If the profile request failed,
      // then throw an exception.
      throw Exception('Failed to get user profile.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: joblist.length,
              itemBuilder: (context, index) {
                final jobListing = joblist[index];
                if (searchQuery.isNotEmpty &&
                    !jobListing.title
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase())) {
                  return Container(); // Skip if the job listing doesn't match the search query
                }
                return ListTile(
                  title: Text(jobListing.title),
                  subtitle: Text(jobListing.company),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetailsPage(
                          jobTitle: jobListing.title,
                          tags: jobListing.tags,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class JobListing {
  final String title;
  final String company;
  final String tags;

  JobListing({
    required this.title,
    required this.company,
    required this.tags,
  });
}
