import 'package:ventas/models/backup/backup.dart';

class BackUpLogic {
  static Future<void> backUpDo() async {
    await BackUp.backUp();
  }
}
