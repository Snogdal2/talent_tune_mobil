import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  String _data = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('https://baconipsum.com/api/?type=meat-and-filler'));
      if (response.statusCode == 200) {
        setState(() {
          _data = response.body;
        });
      } else {
        setState(() {
          _data = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _data = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Page'),
      ),
      body: Center(
        child: _data.isEmpty ? CircularProgressIndicator() : Text(_data),
      ),
    );
  }
}
