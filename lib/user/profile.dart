import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../secure_share_state.dart';
import '../shared_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> _data = {};
  String email = '';

  @override
  void initState() {
    super.initState();
    GetUserProfile();
    loadData();
  }

  loadData() async {
    final userInfo = await SecureSharedState.readAll();
    email = userInfo['email'] ?? '';
    setState(() {});
  }

  Future<String> GetUserProfile() async {
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
        var temp;
        for (temp in _data['documents'] as List<dynamic>) {
          files.add(temp['title']);
        }
      });
      return "true";
    } else {
      // If the profile request failed,
      // then throw an exception.
      throw Exception('Failed to get user profile.');
    }
  }

  bool showFiles = false;

  List<String> files = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showFiles)
              Column(
                children: [
                  const Text(
                    'My Files',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      final file = files[index];
                      return ListTile(
                        title: Text(file),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            final token = SharedState.bearerToken();
                            final deleteResponse = await http.delete(
                              Uri.parse(
                                  'http://localhost:3001/profile/documents/${_data['documents'][index]['_id']}'),
                              // Replace 'http://localhost:3001/files' with your API endpoint
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                                'Authorization': 'Bearer $token',
                              },
                            );

                            if (deleteResponse.statusCode == 200) {
                              // File deletion successful
                              print('File deleted successfully');
                            } else {
                              // File deletion failed
                              throw Exception('Failed to delete file.');
                            }
                            setState(() {
                              files.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        PlatformFile file = result.files.first;

                        // Perform the file upload logic here
                        // You can use the 'http' package or any other package of your choice

                        // Example code to upload the file using 'http' package

                        final token = SharedState.bearerToken();
                        var request = http.MultipartRequest(
                          'POST',
                          Uri.parse('http://localhost:3001/profile/documents'),
                        );

                        request.headers['Authorization'] = 'Bearer $token';
                        request.fields['title'] = file.name;
                        request.fields['encoded'] = base64Encode(file.bytes!);

                        var response = await request.send();
                        if (response.statusCode == 200) {
                          // File uploaded successfully
                          setState(() {
                            files.add(file.name);
                          });
                        } else {
                          // File upload failed
                          print('Failed to upload file');
                        }
                      }
                    },
                    child: const Text('Add File'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showFiles = false;
                      });
                    },
                    child: const Text('View My Profile'),
                  ),
                ],
              )
            else
              Column(
                children: [
                  _data.isEmpty
                      ? const CircularProgressIndicator()
                      : Text(
                          '${'Name: ' + _data['firstName']} ' +
                              _data['lastName'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: $email',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Password: ******',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _data.isEmpty
                      ? const CircularProgressIndicator()
                      : Text(
                          'Bio: ' + _data['bio'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      print(_data);
                    },
                    child: const Text('change my info'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showFiles = true;
                      });
                    },
                    child: const Text('View My Files'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
