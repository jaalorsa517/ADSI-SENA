import 'package:sqflite/sqflite.dart';
import 'package:ventas/config/setup.dart';
import 'package:ventas/models/crud.dart';
import 'package:ventas/models/inventario/inventario.dart';

mixin Inventarios {
  static const Map<String, String> alias = {
    'id': 'id',
    'fecha': 'fecha',
    'idProducto': 'idProducto',
    'producto': 'producto',
    'cantidad': 'cantidad',
    'idCliente': 'idCliente',
    'cliente': 'cliente',
  };

  static Future<bool> create(Inventario inventario) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> _id = await db.rawQuery("""
      SELECT ${Setup.COLUMN_INVENTARIO['id']} AS ${alias['id']} 
      FROM ${Setup.INVENTARIO_TABLE} 
      ORDER BY ${Setup.COLUMN_INVENTARIO['id']} DESC 
      LIMIT 1
      """);
      inventario.id = _id[0][alias['id']] + 1;
      await db.insert(Setup.INVENTARIO_TABLE, _inventarioToMap(inventario)[0]);
      await db.insert(
          Setup.INVENTARIO_PRODUCTO_TABLE, _inventarioToMap(inventario)[1]);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static Future<List<Inventario>> readById(int idCliente) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.rawQuery('''
        SELECT ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['id']} as ${alias['id']}, 
          ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['fecha']} as ${alias['fecha']}, 
		      ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['id']} as ${alias['idProducto']}, 
          ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']} as ${alias['prodcuto']}, 
          ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['cantidad']} as ${alias['cantidad']}, 
          ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_CLIENTE['id']} as ${alias['idCliente']},
	      FROM ${Setup.INVENTARIO_TABLE} 
        JOIN ${Setup.INVENTARIO_PRODUCTO_TABLE} ON 
          ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['id']}=
          ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['id']}
        JOIN ${Setup.PRODUCTO_TABLE} ON 
          ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['id']}= 
          ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['idProducto']}
        JOIN ${Setup.CIUDAD_CLIENTE_TABLE} ON 
        ${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']} = 
        ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['idCliente']}
        WHERE ${alias['idCliente']}=$idCliente
        ORDER BY ${alias['fecha']}, ${alias['cliente']}
      ''');
      return _mapToInventario(list);
    } catch (e) {
      print('Select en inventario' + e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  static Future<bool> update(Inventario inventario) async {
    Database db = await Crud.conectar();
    try {
      await db.update(Setup.INVENTARIO_TABLE, _inventarioToMap(inventario)[0],
          where: '${Setup.COLUMN_INVENTARIO['id']}= inventario.id');
      await db.update(
          Setup.INVENTARIO_PRODUCTO_TABLE, _inventarioToMap(inventario)[1],
          where:
              '${Setup.COLUMN_INVENTARIO_PRODUCTO['idInventario']}= inventario.id');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static Future<bool> delete(int idInventario) async {
    Database db = await Crud.conectar();
    try {
      await db.delete(Setup.INVENTARIO_PRODUCTO_TABLE,
          where:
              '${Setup.COLUMN_INVENTARIO_PRODUCTO['idInventario']}=$idInventario');
      await db.delete(Setup.INVENTARIO_TABLE,
          where: '${Setup.COLUMN_INVENTARIO['id']}=$idInventario');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static List<Map<String, dynamic>> _inventarioToMap(Inventario inventario) {
    Map<String, dynamic> _inventario = {};
    _inventario[Setup.COLUMN_INVENTARIO['id']] = inventario.id;
    _inventario[Setup.COLUMN_INVENTARIO['cantidad']] = inventario.cantidad;
    _inventario[Setup.COLUMN_INVENTARIO['fecha']] = inventario.fecha;
    _inventario[Setup.COLUMN_INVENTARIO['idCliente']] = inventario.idCliente;

    Map<String, dynamic> _inventarioProducto;
    _inventarioProducto[Setup.COLUMN_INVENTARIO_PRODUCTO['idInventario']] =
        inventario.id;
    _inventarioProducto[Setup.COLUMN_INVENTARIO_PRODUCTO['idProducto']] =
        inventario.idProducto;

    return [_inventario, _inventarioProducto];
  }

  static List<Inventario> _mapToInventario(List<Map<String, dynamic>> list) {
    List<Inventario> inventarios = [];
    list.forEach((element) {
      Inventario inventario = Inventario();
      inventario.id = element[alias['id']];
      inventario.fecha = element[alias['fecha']];
      inventario.idProducto = element[alias['idProducto']];
      inventario.producto = element[alias['producto']];
      inventario.cantidad = element[alias['cantidad']] ?? 0;
      inventario.idCliente = element[alias['idCliente']];
      inventario.cliente = element[alias['cliente']];
      inventarios.add(inventario);
    });
    return inventarios;
  }
}
