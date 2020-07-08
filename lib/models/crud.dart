import 'dart:io';

import 'package:flutter/services.dart';
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

      if (db_path != null) {
        //COPIAR LA BASE DE DATOS DESDE EL RECURSO
        ByteData data = await rootBundle.load(join('data', _name));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(db_path).writeAsBytes(bytes);
      }

      return await openDatabase(db_path);
    } catch (Exception) {
      print('EXCEPTION EN CONECTAR ${Exception.toString()}');
      return null;
    }
  }
}
