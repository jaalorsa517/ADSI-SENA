import 'package:ventas/config/utilidades.dart';
import 'package:ventas/models/backup/backup.dart';

class BackUpLogic {
  static Future<void> backUpDo() async {
    await BackUp.backUp();
    cliente.loadCliente();
  }
}
