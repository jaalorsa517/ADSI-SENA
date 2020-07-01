import 'package:sqflite/sqflite.dart';
import 'package:ventas/config/setup.dart';
import 'package:ventas/models/crud.dart';
import 'package:ventas/models/producto/producto.dart';

class Productos implements Crud {
  static Future<bool> create(Producto producto) async {
    Database db = await Crud.conectar();
    try {
      await db.insert(Setup.CLIENT_TABLE, _productoToMap(producto));
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<List<Producto>> read() async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.query(Setup.PRODUCTO_TABLE);
      return _mapToProducto(list);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<bool> update(Producto producto) async {
    Database db = await Crud.conectar();
    try {
      await db.update(Setup.CLIENT_TABLE, _productoToMap(producto));
      return true;
    } catch (e) {
      print(e.toString());
      return false;
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
    }
  }

  static List<Object> readById(Object object) {}

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
