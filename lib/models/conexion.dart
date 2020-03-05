import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class Conexion {
  String mensaje = '';
  Database db;

  Future<bool> conectar(String name) async {
    try {
      String db_path = join(await getDatabasesPath(), name);

      //COPIAR LA BASE DE DATOS DESDE EL RECURSO
      ByteData data = await rootBundle.load(join('data', name));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(db_path).writeAsBytes(bytes);

      this.db = await openDatabase(db_path);
      this.mensaje = 'Conexión correcta';
      return true;

    } catch (Exception) {
      this.mensaje = 'Conexión incorrecta';
      
      print('EXCEPTION EN CONECTAR ${Exception.toString()}');
      
      return false;
    }
  }
}

abstract class Crud {
  Map<String, dynamic> toMap() => {};

  Future<List> select();

  bool actualizar();

  bool borrar();

  bool insertar(dynamic objeto);
}
