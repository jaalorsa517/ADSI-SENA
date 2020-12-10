import 'package:sqflite/sqlite_api.dart';
import 'package:ventas/config/setup.dart';
import 'package:ventas/models/crud.dart';

import 'ciudad.dart';

class Ciudades {
  static const Map<String, String> _alias = {'id': 'id', 'nom': 'nombre'};

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

  static Future<List<Ciudad>> readByName(String nombreCiudad) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.query(Setup.CIUDAD_TABLE,
          where:
              '${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD['nombre']}=\'$nombreCiudad\'');
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
      ciudad.id = element[_alias['id']];
      ciudad.nombre = element[_alias['nom']];
      ciudades.add(ciudad);
    });
    return ciudades;
  }
}
