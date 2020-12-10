import 'package:sqflite/sqflite.dart';
import 'package:ventas/config/setup.dart';
import 'package:ventas/models/crud.dart';
import 'package:ventas/models/venta/historial/inventario_historial.dart';
import 'package:ventas/models/venta/inventario/inventario.dart';

class Inventarios {
  static const Map<String, String> _alias = {
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
      SELECT ${Setup.COLUMN_INVENTARIO['id']} AS ${_alias['id']} 
      FROM ${Setup.INVENTARIO_TABLE} 
      ORDER BY ${Setup.COLUMN_INVENTARIO['id']} DESC 
      LIMIT 1
      """);
      inventario.id = _id[0][_alias['id']] + 1 ?? 1;
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

  static Future<List<InventarioHistorial>> readHistoryGeneral(
      int idCliente) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.rawQuery("""
      SELECT 
        ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['fecha']} AS ${_alias['fecha']}, 
        ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']} AS ${_alias['producto']},
        ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['cantidad']} AS ${_alias['cantidad']}
      FROM ${Setup.INVENTARIO_TABLE} 
      INNER JOIN ${Setup.CLIENTE_TABLE} ON 
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']} =
        ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['idCliente']} 
      INNER JOIN ${Setup.PRODUCTO_TABLE} ON 
        ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['id']}= 
        ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['idProducto']}
      INNER JOIN ${Setup.INVENTARIO_PRODUCTO_TABLE} ON 
        ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['idInventario']}=
         ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['id']}
      WHERE ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']}=$idCliente
      ORDER BY ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']}
      """);
      return _mapToInventarioHistorial(list);
    } catch (e) {
      print('Select en inventario' + e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  static Future<List<InventarioHistorial>> readHistoryProducto(
      int idCliente, int idProducto) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.rawQuery("""
      SELECT 
        ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['fecha']} AS ${_alias['fecha']}, 
        ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']} AS ${_alias['producto']},
        ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['cantidad']} AS ${_alias['cantidad']}
      FROM ${Setup.INVENTARIO_TABLE} 
      INNER JOIN ${Setup.CLIENTE_TABLE} ON 
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']} =
        ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['idCliente']} 
      INNER JOIN ${Setup.PRODUCTO_TABLE} ON 
        ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['id']}= 
        ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['idProducto']}
      INNER JOIN ${Setup.INVENTARIO_PRODUCTO_TABLE} ON 
        ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['idInventario']}=
         ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['id']}
      WHERE ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']}=$idCliente
        AND ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['id']}=$idProducto
      ORDER BY ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']}
      """);
      return _mapToInventarioHistorial(list);
    } catch (e) {
      print('Select en inventario' + e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  static Future<List<InventarioHistorial>> readInventaryDate(
      int idCliente, String date) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.rawQuery("""
      SELECT 
        ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['fecha']} AS ${_alias['fecha']}, 
        ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']} AS ${_alias['producto']},
        ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['cantidad']} AS ${_alias['cantidad']}
      FROM ${Setup.INVENTARIO_TABLE} 
      INNER JOIN ${Setup.CLIENTE_TABLE} ON 
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']} =
        ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['idCliente']} 
      INNER JOIN ${Setup.PRODUCTO_TABLE} ON 
        ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['id']}= 
        ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['idProducto']}
      INNER JOIN ${Setup.INVENTARIO_PRODUCTO_TABLE} ON 
        ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['idInventario']}=
         ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['id']}
      WHERE ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']}=$idCliente
        AND ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['fecha']}=$date
      ORDER BY ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']}
      """);
      return _mapToInventarioHistorial(list);
    } catch (e) {
      print('Select en inventario' + e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  static Future<List<String>> readProductOnly(int idCliente) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> listMap = await db.rawQuery("""
        SELECT ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']}
        FROM ${Setup.PRODUCTO_TABLE}
        INNER JOIN ${Setup.INVENTARIO_TABLE} 
          ON ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['id']} =
            ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['idInventario']}
        INNER JOIN ${Setup.INVENTARIO_PRODUCTO_TABLE} 
          ON ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['idProducto']}=
            ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['id']}
        INNER JOIN ${Setup.CLIENTE_TABLE} 
          ON ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']}=
            ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['idCliente']}
        WHERE ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']}=$idCliente
        GROUP BY ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']}
        ORDER BY ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']} ASC
        """);
      return List.generate(listMap.length,
          (index) => listMap[index][Setup.COLUMN_PRODUCTO['nombre']]);
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

  // static List<Inventario> _mapToInventario(List<Map<String, dynamic>> list) {
  //   List<Inventario> inventarios = [];
  //   list.forEach((element) {
  //     Inventario inventario = Inventario();
  //     inventario.id = element[_alias['id']];
  //     inventario.fecha = element[_alias['fecha']];
  //     inventario.idProducto = element[_alias['idProducto']];
  //     inventario.producto = element[_alias['producto']];
  //     inventario.cantidad = element[_alias['cantidad']] ?? 0;
  //     inventario.idCliente = element[_alias['idCliente']];
  //     inventario.cliente = element[_alias['cliente']];
  //     inventarios.add(inventario);
  //   });
  //   return inventarios;
  // }

  static List<InventarioHistorial> _mapToInventarioHistorial(
      List<Map<String, dynamic>> list) {
    List<InventarioHistorial> _list = [];
    list.forEach((element) {
      InventarioHistorial history = InventarioHistorial();
      history.fechaPedido = element[_alias['fecha']];
      history.nombreProducto = element[_alias['producto']];
      history.cantidad = element[_alias['cantidad']];
      _list.add(history);
    });
    return _list;
  }
}
