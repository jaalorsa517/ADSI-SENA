import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ventas/config/setup.dart';

abstract class Crud {
  // ignore: missing_return
  static Future<bool> create(Object object) {}
  // ignore: missing_return
  static Future<List<Object>> read() {}
  // ignore: missing_return
  static Future<bool> update(Object object) {}
  // ignore: missing_return
  static Future<bool> delete(int idObject) {}
  // ignore: missing_return
  static Future<List<Object>> readById(Object object) {}
  static Future<Database> conectar() async {
    String _name = Setup.DB_NAME;
    try {
      String dbPath = join(await getDatabasesPath(), _name);
      return await openDatabase(dbPath, version: 1);
    } catch (Exception) {
      print('EXCEPTION EN CONECTAR ${Exception.toString()}');
      return null;
    }
  }
}
