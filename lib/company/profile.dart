import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../shared_state.dart';

class CompanyInfoPage extends StatefulWidget {
  const CompanyInfoPage({super.key});

  @override
  _CompanyInfoPageState createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
  Map<String, dynamic> _data = {};
  String _name = '';
  String _address = '';
  String _phoneNumber = '';
  String _email = '';
  @override
  void initState() {
    super.initState();
    GetcompanyProfile();
  }
  Future<String> GetcompanyProfile() async {
    final token = SharedState.bearerToken();
    final profileResponse = await http.get(
      Uri.parse('http://localhost:3001/profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (profileResponse.statusCode == 200) {
      // If the profile request was successful,
      // then parse the profile JSON.
      setState(() {
        _data = jsonDecode(profileResponse.body) as Map<String, dynamic>;
        print(_data);
        setState(() {});  
      });
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to our company!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
             _data.isEmpty
                      ? const CircularProgressIndicator()
                      : Text(
                          '${'Name: ' + _data['name']}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
            const SizedBox(height: 8),
             _data.isEmpty
                      ? const CircularProgressIndicator()
                      : Text(
                          '${'description: ' + _data['description']}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
            const SizedBox(height: 8),
             _data.isEmpty
                      ? const CircularProgressIndicator()
                      : Text(
                          '${'vat: ' + _data['vat']}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
            const SizedBox(height: 8),
             _data.isEmpty
                      ? const CircularProgressIndicator()
                      : Text(
                          '${'country: ' + _data['country']}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
          ],
        ),
      ),
    );
  }
}
