import 'package:flutter/material.dart';

class CandidatePage extends StatelessWidget {
  const CandidatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          final candidate = candidates[index];
          return ListTile(
            title: Text(candidate.name),
            subtitle: Text(candidate.jobTitle),
            onTap: () {
              // Handle candidate selection
            },
          );
        },
      ),
    );
  }
}

class Candidate {
  final String name;
  final String jobTitle;

  Candidate({required this.name, required this.jobTitle});
}

// Example list of candidates
List<Candidate> candidates = [
  Candidate(name: 'John Doe', jobTitle: 'Software Engineer'),
  Candidate(name: 'Jane Smith', jobTitle: 'UI/UX Designer'),
  Candidate(name: 'Mike Johnson', jobTitle: 'Data Analyst'),
];