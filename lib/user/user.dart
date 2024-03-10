import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'joblisting.dart';
import 'profile.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const ChatPage(),
    const JobListingPage(),
    const ProfilePage(),
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
                child: Text('Ai page'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Job Listing Page'),
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

