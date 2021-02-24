import 'package:sqflite/sqflite.dart';
import 'package:edertiz/config/setup.dart';
import 'package:edertiz/models/crud.dart';

class Import {
  static Future<bool> importClientes(List<List> rows) async {
    bool response = false;
    Database _db = await Crud.conectar();
    try {
      await _db.transaction((db) async {
        rows.forEach((row) async {
          int id = await db.insert(Setup.CLIENTE_TABLE, {
            Setup.COLUMN_CLIENTE['nit']: row[0],
            Setup.COLUMN_CLIENTE['nombre']: row[1],
            Setup.COLUMN_CLIENTE['admin']: row[2],
            Setup.COLUMN_CLIENTE['telefono']: row[3],
            Setup.COLUMN_CLIENTE['direccion']: row[4],
            Setup.COLUMN_CLIENTE['email']: row[5],
          });
          await db.rawInsert("""
            INSERT INTO ${Setup.CIUDAD_CLIENTE_TABLE}
            VALUES ($id,(
              SELECT id FROM ${Setup.CIUDAD_TABLE} 
                WHERE ${Setup.COLUMN_CIUDAD['nombre']} = '${row[6]}'))
            """);
        });
        response = true;
      });
    } catch (e) {
      print('Insert producto' + e.toString());
    } finally {
      _db.close();
    }
    return response;
  }

  static Future<bool> importProductos(List<List> rows) async {
    bool onError = false;
    Database _db = await Crud.conectar();
    await _db.transaction((db) async {
      for (int i = 0; i < rows.length; i++) {
        await db.insert(Setup.PRODUCTO_TABLE, {
          Setup.COLUMN_PRODUCTO['id']: rows[i][0],
          Setup.COLUMN_PRODUCTO['nombre']: rows[i][1],
          Setup.COLUMN_PRODUCTO['precio']: rows[i][2],
          Setup.COLUMN_PRODUCTO['iva']: rows[i][3],
        })
        .catchError((e) {
          print('Error en insert de transaction ' + e.toString());
          onError = true;
        });
        if (onError) break;
      }
    }).catchError((e) => print("Error en Transaction " + e.toString()));
    _db.close();
    return !onError ? true : false;
  }
}
