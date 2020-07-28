import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ventas/config/setup.dart';

abstract class Crud {
  static Future<bool> create(Object object) {}
  static Future<List<Object>> read() {}
  static Future<bool> update(Object object) {}
  static Future<bool> delete(int idObject) {}
  static Future<List<Object>> readById(Object object) {}
  static Future<Database> conectar() async {
    String _name = Setup.DB_NAME;
    try {
      String db_path = join(await getDatabasesPath(), _name);
      return await openDatabase(db_path);
    } catch (Exception) {
      print('EXCEPTION EN CONECTAR ${Exception.toString()}');
      return null;
    }
  }
}
