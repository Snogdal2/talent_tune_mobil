import 'package:flutter/material.dart';
import 'JobDetail.dart';

class JobListingPage extends StatefulWidget {
  const JobListingPage({Key? key}) : super(key: key);

  @override
  _JobListingPageState createState() => _JobListingPageState();
}

class _JobListingPageState extends State<JobListingPage> {
  String searchQuery = '';

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
              itemCount: jobListings.length,
              itemBuilder: (context, index) {
                final jobListing = jobListings[index];
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
                          jobDescription: jobListing.jobDescription,
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
  final String jobDescription;

  JobListing({
    required this.title,
    required this.company,
    required this.jobDescription,
  });
}

// Sample job listings data
List<JobListing> jobListings = [
  JobListing(
    title: 'Job 1',
    company: 'Company A',
    jobDescription: 'Description 1',
  ),
  JobListing(
    title: 'Job 2',
    company: 'Company B',
    jobDescription: 'Description 2',
  ),
  JobListing(
    title: 'Job 3',
    company: 'Company C',
    jobDescription: 'Description 3',
  ),
];
