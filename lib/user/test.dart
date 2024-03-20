import 'dart:convert';

import 'package:http/http.dart' as http;

import '../shared_state.dart';

void fetchData() async {
  final token = SharedState.bearerToken();
  final response =
      await http.post(Uri.parse('http://localhost:3001/assistant/initialize'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(<String, String>{
            'resume': 'my name is james and hard working',
            'jobDescription':
                'it support. hard working and good communication skills'
          }));

  if (response.statusCode == 200) {
    print(response.body);
    const totalChunks = 10; // Total number of chunks to receive
    final chunkSize = response.body.length ~/ totalChunks;

    for (var i = 0; i < totalChunks; i++) {
      final start = i * chunkSize;
      final end = (i + 1) * chunkSize;

      final chunk = response.body.substring(start, end);
      displayChunk(chunk);

      await Future.delayed(const Duration(seconds: 1)); // Delay between chunks
    }
  } else {
    print('Failed to fetch data. Error: ${response.statusCode}');
  }
}

void displayChunk(String chunk) {
  // Display the chunk live as it arrives
  print('Received chunk: $chunk');
}
