import 'package:permission_handler/permission_handler.dart';

void requestPermission() async {
  await Permission.storage.request();
}
