import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class Conexion {
  String mensaje = '';
  Database db;
  bool _sw = false;

  Future<bool> conectar(String name, AssetBundle asset) async {
    try {
      String db_path = join(await getDatabasesPath(), name);

      if (!_sw) {
        //COPIAR LA BASE DE DATOS DESDE EL RECURSO
        ByteData data = await asset.load(join('data', name));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(db_path).writeAsBytes(bytes);
        _sw = true;
      }

      this.db = await openDatabase(db_path);
      this.mensaje = 'Conexión correcta';
      return true;
    } catch (Exception) {
      this.mensaje = 'Conexión incorrecta';

      print('EXCEPTION EN CONECTAR ${Exception.toString()}');

      return false;
    }
  }

  void desconectar() {
    this.db.close();
  }
}

abstract class Crud {
  Future<List> select();

  // bool actualizar();

  // bool borrar();

  // bool insertar(dynamic objeto);
}
