import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:edertiz/config/setup.dart';

class BackUp {
  static Future<void> backUp() async {
    String _name = Setup.DB_NAME;
    String dbPath = join(await getDatabasesPath(), _name);
    await deleteDatabase(dbPath);
    //COPIAR LA BASE DE DATOS DESDE EL RECURSO
    ByteData data = await rootBundle.load(join('data', _name));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
  }
}
