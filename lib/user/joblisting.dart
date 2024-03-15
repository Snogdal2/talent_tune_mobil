import 'dart:convert';

import 'package:flutter/material.dart';
import '../shared_state.dart';
import 'JobDetail.dart';
import 'package:http/http.dart' as http;

class JobListingPage extends StatefulWidget {
  const JobListingPage({super.key});

  @override
  _JobListingPageState createState() => _JobListingPageState();
}

class _JobListingPageState extends State<JobListingPage> {
  String searchQuery = '';
  List<dynamic> temp2 = [];
  var _data = {};
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
      var temp =  jsonDecode(joblistingResponse.body) as Map<String, dynamic>;
       temp2 = temp['data'][0]['jobListings'] as List<dynamic>;
      print(temp2);
      // for (var temp1 in temp.keys) {
      //   print(temp1);
      // }
      // print(temp);
      // If the profile request was successful,
      // then parse the profile JSON.
      // JobListingb jobListingb = JobListingb.fromJson(jsonDecode(joblistingResponse.body));
      // var temp = json.decode(joblistingResponse.body) as Map<String, dynamic>;
      // var temp2 = temp['data'][0]['jobListings'];
      // final jsonMap = json.decode(jsonString);
      // List<JobListing> temp4 = (jsonMap['data'] as List)
      //     .map((itemWord) => JobListing.fromJson(itemWord))
      //     .toList();

      // print(temp);
       //print(jobListingb);
      setState(() {

      });
      // print(_data['data'][0]['jobListings']);
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
              itemCount: temp2.length,
              itemBuilder: (context, index) {
                final jobListing = temp2[index];
                if (searchQuery.isNotEmpty &&
                    !jobListing.title.toLowerCase().contains(searchQuery.toLowerCase())) {
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

// Sample job listings data
List<JobListing> jobListings = [
  JobListing(
    title: 'Job 1',
    company: 'Company A',
    tags: 'Description 1',
  ),
  JobListing(
    title: 'Job 2',
    company: 'Company B',
    tags: 'Description 2',
  ),
  JobListing(
    title: 'Job 3',
    company: 'Company C',
    tags: 'Description 3',
  ),
];
class JobListingb {
  String title;
  String description;

  JobListingb(this.title, this.description);

  factory JobListingb.fromJson(dynamic json) {
  //  print("josn" + json);
    return JobListingb(json['title'] as String, json['description'] as String);

  }

  @override
  String toString() {
    return '{ ${this.title}, ${this.description}}';
  }
}