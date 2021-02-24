import 'package:sqflite/sqflite.dart';
import 'package:edertiz/config/setup.dart';
import 'package:edertiz/models/crud.dart';
import 'package:edertiz/models/producto/producto.dart';

class Productos {
  static const Map<String, String> _alias = {
    'id': 'id',
    'nom': 'nombre',
    'precio': 'precio',
    'iva': 'iva'
  };
  static Future<bool> create(Producto producto) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> _id = await db.rawQuery("""
      SELECT ${Setup.COLUMN_PRODUCTO['id']} AS ${_alias['id']} 
      FROM ${Setup.PRODUCTO_TABLE} 
      ORDER BY ${Setup.COLUMN_PRODUCTO['id']} DESC 
      LIMIT 1
      """);
      producto.id = _id[0][_alias['id']] + 1 ?? 1;
      await db.insert(Setup.PRODUCTO_TABLE, _productoToMap(producto));
      return true;
    } catch (e) {
      print('Insert producto' + e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static Future<List<Producto>> read() async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.rawQuery(
          'SELECT * FROM ${Setup.PRODUCTO_TABLE} ORDER BY ${_alias['nom']} ASC');
      return _mapToProducto(list);
    } catch (e) {
      print('metodo read en producto ' + e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  static Future<List<Producto>> readByName(String name) async {
    // ignore: avoid_init_to_null
    List<Producto> response = null;
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list =
          await db.rawQuery("""SELECT * FROM producto WHERE 
              ${Setup.COLUMN_PRODUCTO['nombre']} LIKE \'%$name%\' 
              ORDER BY ${_alias['nom']} ASC""");
      response = _mapToProducto(list);
    } catch (e) {
      print(e.toString());
    } finally {
      db.close();
    }
    return response;
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
      await db.rawUpdate("""
          UPDATE ${Setup.PRODUCTO_TABLE} 
          SET ${Setup.COLUMN_PRODUCTO['nombre']}=\'${producto.nombre}\', 
              ${Setup.COLUMN_PRODUCTO['precio']}=${producto.precio}, 
              ${Setup.COLUMN_PRODUCTO['iva']}=${producto.iva} 
          WHERE ${Setup.COLUMN_PRODUCTO['id']}=${producto.id}""");
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
          where: '${Setup.COLUMN_PRODUCTO['id']}=$idProducto');
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
      producto.id = element[_alias['id']];
      producto.nombre = element[_alias['nom']];
      producto.precio = element[_alias['precio']];
      producto.iva = element[_alias['iva']];
      productos.add(producto);
    });
    return productos;
  }

  static Map<String, dynamic> _productoToMap(Producto producto) {
    Map<String, dynamic> _producto = {};
    _producto[Setup.COLUMN_PRODUCTO['id']] = producto.id;
    _producto[Setup.COLUMN_PRODUCTO['nombre']] = producto.nombre;
    _producto[Setup.COLUMN_PRODUCTO['precio']] = producto.precio;
    _producto[Setup.COLUMN_PRODUCTO['iva']] = producto.iva;
    return _producto;
  }
}
