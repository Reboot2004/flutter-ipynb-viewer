import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FlaskServerScreen extends StatelessWidget {
  final String serverUrl;

  FlaskServerScreen({required this.serverUrl});

  Future<void> _loadModel(String modelName) async {
    final response = await http.post(
      Uri.parse('$serverUrl/load_model'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'model_name': modelName}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load model');
    }
  }

  Future<void> _runModel(String modelName, Map<String, dynamic> inputData) async {
    final response = await http.post(
      Uri.parse('$serverUrl/run_model'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'model_name': modelName, 'input_data': inputData}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to run model');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flask Server'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  await _loadModel('tensorflow_model');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Model loaded successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to load model: $e')),
                  );
                }
              },
              child: Text('Load TensorFlow Model'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _runModel('tensorflow_model', {'input': 'data'});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Model run successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to run model: $e')),
                  );
                }
              },
              child: Text('Run TensorFlow Model'),
            ),
          ],
        ),
      ),
    );
  }
}
