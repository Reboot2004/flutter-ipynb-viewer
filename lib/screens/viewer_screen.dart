import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ViewerScreen extends StatelessWidget {
  final String filePath;

  ViewerScreen({required this.filePath});

  Future<Map<String, dynamic>> _loadNotebook() async {
    final file = File(filePath);
    final content = await file.readAsString();
    return json.decode(content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jupyter Notebook Viewer'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _loadNotebook(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          } else {
            final notebook = snapshot.data!;
            return ListView.builder(
              itemCount: notebook['cells'].length,
              itemBuilder: (context, index) {
                final cell = notebook['cells'][index];
                if (cell['cell_type'] == 'markdown') {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(cell['source'].join('')),
                  );
                } else if (cell['cell_type'] == 'code') {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cell['source'].join('')),
                        SizedBox(height: 8.0),
                        if (cell['outputs'] != null)
                          ...cell['outputs'].map<Widget>((output) {
                            if (output['output_type'] == 'stream') {
                              return Text(output['text'].join(''));
                            } else if (output['output_type'] == 'execute_result' ||
                                output['output_type'] == 'display_data') {
                              return Text(output['data']['text/plain'].join(''));
                            } else {
                              return Container();
                            }
                          }).toList(),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          }
        },
      ),
    );
  }
}
