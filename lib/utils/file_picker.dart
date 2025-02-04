import 'package:file_picker/file_picker.dart';

class FilePickerUtil {
  static Future<String?> pickIpynbFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.all,
    );

    if (result != null) {
      return result.files.single.path;
    } else {
      return null;
    }
  }
}
