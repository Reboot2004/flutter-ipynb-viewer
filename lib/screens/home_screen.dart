import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'viewer_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Jupyter Notebook Viewer'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.any
            );

            if (result != null) {
              String? filePath = result.files.single.path;
              if (filePath != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewerScreen(filePath: filePath),
                  ),
                );
              }
            }
          },
          child: Text('Open Jupyter Notebook'),
        ),
      ),
    );
  }
}
