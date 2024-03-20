import 'package:flutter/material.dart';

class ApplicantDetailsPage extends StatelessWidget {
  final String candidateName;
  final String candidatejobTitle;

  ApplicantDetailsPage({
    required this.candidateName,
    required this.candidatejobTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candidate Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $candidateName',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'jobTitle: $candidatejobTitle',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}