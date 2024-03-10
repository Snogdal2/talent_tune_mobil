import 'package:flutter/material.dart';

class JobListingPage extends StatelessWidget {
  const JobListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: jobListings.length,
        itemBuilder: (context, index) {
          final jobListing = jobListings[index];
          return ListTile(
            title: Text(jobListing.title),
            subtitle: Text(jobListing.company),
            onTap: () {
              // Handle job listing tap
            },
          );
        },
      ),
    );
  }
}

class JobListing {
  final String title;
  final String company;

  JobListing({required this.title, required this.company});
}

// Sample job listings data
List<JobListing> jobListings = [
  JobListing(title: 'Job 1', company: 'Company A'),
  JobListing(title: 'Job 2', company: 'Company B'),
  JobListing(title: 'Job 3', company: 'Company C'),
];