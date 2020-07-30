import 'package:sqflite/sqflite.dart';
import 'package:ventas/config/setup.dart';
import 'package:ventas/models/crud.dart';
import 'package:ventas/models/producto/producto.dart';

class Productos implements Crud {
  static Future<bool> create(Producto producto) async {
    Database db = await Crud.conectar();
    try {
      await db.rawInsert(
          'INSERT INTO ${Setup.PRODUCTO_TABLE} (${Setup.COLUMN_PRODUCTO[1]}' +
              ',${Setup.COLUMN_PRODUCTO[2]},${Setup.COLUMN_PRODUCTO[3]})' +
              'VALUES (\'${producto.nombre}\',${producto.precio},${producto.iva})');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static Future<List<Producto>> read() async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list =
          await db.rawQuery('SELECT * FROM producto ORDER BY nombre ASC');
      return _mapToProducto(list);
    } catch (e) {
      print('metodo read en producto ' + e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  static Future<List<Producto>> readByName(String name) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.rawQuery(
          'SELECT * FROM producto WHERE ' +
              '${Setup.COLUMN_PRODUCTO[1]} LIKE \'%$name%\' ' +
              'ORDER BY ${Setup.COLUMN_PRODUCTO[1]} ASC');
      return _mapToProducto(list);
    } catch (e) {
      print(e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  /* static Future<List<Producto>> readById(int id) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.query(Setup.PRODUCTO_TABLE,
          where: '${Setup.COLUMN_PRODUCTO[0]}=$id');
      return _mapToProducto(list);
    } catch (e) {
      print(e.toString());
      return null;
    } finally {
      db.close();
    }
  } */

  static Future<bool> update(Producto producto) async {
    Database db = await Crud.conectar();
    try {
      // await db.update(Setup.CLIENT_TABLE, _productoToMap(producto));
      await db.rawUpdate(
          'UPDATE ${Setup.PRODUCTO_TABLE} SET ${Setup.COLUMN_PRODUCTO[1]}=\'${producto.nombre}\', ' +
              '${Setup.COLUMN_PRODUCTO[2]}=${producto.precio}, ${Setup.COLUMN_PRODUCTO[3]}=${producto.precio} ' +
              'WHERE ${Setup.COLUMN_PRODUCTO[0]}=${producto.id}');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static Future<bool> delete(int idProducto) async {
    Database db = await Crud.conectar();
    try {
      await db.delete(Setup.PRODUCTO_TABLE,
          where: '${Setup.COLUMN_PRODUCTO[0]}=$idProducto');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static List<Producto> _mapToProducto(List<Map<String, dynamic>> list) {
    List<Producto> productos = [];
    list.forEach((element) {
      Producto producto = Producto();
      producto.id = element[Setup.COLUMN_PRODUCTO[0]];
      producto.nombre = element[Setup.COLUMN_PRODUCTO[1]];
      producto.precio = element[Setup.COLUMN_PRODUCTO[2]];
      producto.iva = element[Setup.COLUMN_PRODUCTO[3]];
      productos.add(producto);
    });
    return productos;
  }

  static Map<String, dynamic> _productoToMap(Producto producto) {
    Map<String, dynamic> mapProducto = {};
    mapProducto[Setup.COLUMN_PRODUCTO[0]] = producto.id;
    mapProducto[Setup.COLUMN_PRODUCTO[1]] = producto.nombre;
    mapProducto[Setup.COLUMN_PRODUCTO[2]] = producto.precio;
    mapProducto[Setup.COLUMN_PRODUCTO[3]] = producto.iva;
    return mapProducto;
  }
}
