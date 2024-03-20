import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'candidate.dart';
import 'profile.dart';

class company extends StatefulWidget {
  const company({super.key});

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<company> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const ApplicantsPage(),
    const CandidatePage(),
    const CompanyInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            onSelected: (int index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Job Listing Page'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Candidates page'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Profile Page'),
              ),
            ],
          ),
        ],
      ),
      body: _pages[_currentPageIndex],
    );
  }
}
