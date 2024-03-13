import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showFiles = false;

  List<String> files = ["file1", "file2", "file3"];

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
                          onPressed: () {
                            setState(() {
                              files.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          String newFile = '';
                          return AlertDialog(
                            title: const Text('Add File'),
                            content: TextField(
                              onChanged: (value) {
                                newFile = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    files.add(newFile);
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Text('Add'),
                              ),
                            ],
                          );
                        },
                      );
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
                  const Text(
                    'Name: John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Email: Johndoe@mail.com',
                    style: TextStyle(
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
                  const Text(
                    'Bio: Software Developer',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
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
