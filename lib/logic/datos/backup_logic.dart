import 'package:edertiz/config/utilidades.dart';
import 'package:edertiz/models/backup/backup.dart';

class BackUpLogic {
  static Future<void> backUpDo() async {
    await BackUp.backUp();
    cliente.loadCliente();
  }
}
