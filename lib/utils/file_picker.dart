import 'package:file_picker/file_picker.dart';

class FilePickerUtil {
  static Future<String?> pickIpynbFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['ipynb'],
      );

      return result?.files.single.path;
    } catch (e) {
      print("File Picker Error: $e");
      return null;
    }
  }
}
