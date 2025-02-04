import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerUtil {
  static Future<bool> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted ||
        await Permission.manageExternalStorage.request().isGranted) {
      return true;
    }
    return false;
  }
}
