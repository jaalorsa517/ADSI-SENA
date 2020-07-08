import 'package:sqflite/sqlite_api.dart';
import 'package:ventas/config/setup.dart';
import 'package:ventas/models/crud.dart';

import 'ciudad.dart';

class Ciudades implements Crud {
  static Future<bool> create(Ciudad ciudad) async {
    Database db = await Crud.conectar();
    try {
      await db.rawInsert("INSERT INTO ${Setup.CIUDAD_TABLE} " +
          "(${Setup.COLUMN_CIUDAD[1]}) " +
          "VALUES (${ciudad.nombre})");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<List<Ciudad>> read() async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.query(Setup.CIUDAD_TABLE);
      return _mapToCiudad(list);
    } catch (e) {
      print(e.toString);
      return null;
    }
  }

  static Future<bool> update(Ciudad ciudad) async {
    Database db = await Crud.conectar();
    try {
      await db.rawUpdate("UPDATE ${Setup.CIUDAD_TABLE} " +
          "SET ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[1]}= ${ciudad.nombre} " +
          "WHERE ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[0]}= ciudad.id");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> delete(int idCiudad) async {
    Database db = await Crud.conectar();
    try {
      await db.delete(Setup.CIUDAD_TABLE,
          where: " ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[0]}= $idCiudad");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<List<Ciudad>> readById(int idCiudad) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.query(Setup.CIUDAD_TABLE,
          where: '${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[0]}=$idCiudad');
      return _mapToCiudad(list);
    } catch (e) {
      print(e.toString);
      return null;
    }
  }

  static Future<List<Ciudad>> readByName(String nombreCiudad) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.query(Setup.CIUDAD_TABLE,
          where:
              '${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[1]}=\'$nombreCiudad\'');
      return _mapToCiudad(list);
    } catch (e) {
      print(e.toString);
      return null;
    }
  }

  static List<Ciudad> _mapToCiudad(List<Map<String, dynamic>> list) {
    List<Ciudad> ciudades = [];
    list.forEach((element) {
      Ciudad ciudad = Ciudad();
      ciudad.id = element[Setup.COLUMN_CIUDAD[0]];
      ciudad.nombre = element[Setup.COLUMN_CIUDAD[1]];
      ciudades.add(ciudad);
    });
    return ciudades;
  }

  static Map<String, dynamic> _ciudadToMap(Ciudad ciudad) {
    Map<String, dynamic> mapCiudad = {};
    mapCiudad[Setup.COLUMN_CLIENTE[0]] = ciudad.id;
    mapCiudad[Setup.COLUMN_CLIENTE[1]] = ciudad.nombre;
    return mapCiudad;
  }
}
