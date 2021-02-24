import 'package:edertiz/config/utilidades.dart';
import 'package:sqflite/sqflite.dart';
import 'package:edertiz/config/setup.dart';
import 'package:edertiz/models/crud.dart';

class Inventarios {
  static const Map<String, String> _alias = {
    'id': 'id',
    'fecha': 'fecha',
    'idProducto': 'idProducto',
    'producto': 'producto',
    'cantidad': 'cantidad',
    'idCliente': 'idCliente',
    'cliente': 'cliente',
    'precio': 'precio',
    'pedido': 'pedido',
    'fechaEntrega': 'fechaEntrega'
  };

  static Future<bool> create(String fechaPedido, int cantidad, int idCliente,
      int idProducto, String fechaEntrega, int pedido, int valor) async {
    bool onError = false;
    Database db = await Crud.conectar();
    await db.transaction((txn) async {
      int idInventario = await txn.insert(Setup.INVENTARIO_TABLE, {
        Setup.COLUMN_INVENTARIO['cantidad']: cantidad,
        Setup.COLUMN_INVENTARIO['fecha']: fechaPedido,
        Setup.COLUMN_INVENTARIO['idCliente']: idCliente,
      }).catchError((e) {
        print("error en insert " + e.toString());
        onError = true;
      });
      await txn.insert(Setup.INVENTARIO_PRODUCTO_TABLE, {
        Setup.COLUMN_INVENTARIO_PRODUCTO['idInventario']: idInventario,
        Setup.COLUMN_INVENTARIO_PRODUCTO['idProducto']: idProducto,
      }).catchError((e) {
        print("error en insert " + e.toString());
        onError = true;
      });
      await txn.insert(Setup.PEDIDO_TABLE, {
        Setup.COLUMN_PEDIDO['fechaPedido']: fechaPedido,
        Setup.COLUMN_PEDIDO['fechaEntrega']: fechaEntrega,
        Setup.COLUMN_PEDIDO['idInventario']: idInventario,
        Setup.COLUMN_PEDIDO['cantidad']: pedido,
        Setup.COLUMN_PEDIDO['valor']: valor,
      }).catchError((e) {
        print("error en insert " + e.toString());
        onError = true;
      });
    });

    db.close();
    return !onError ? true : false;
  }

  static Future<List<Map<String, dynamic>>> readHistoryProduct(
      int idCliente, int idProducto) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.rawQuery("""
      SELECT 
        ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['fecha']} AS ${_alias['fecha']}, 
        ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']} AS ${_alias['producto']},
        ${Setup.PEDIDO_TABLE}.${Setup.COLUMN_PEDIDO['cantidad']} AS ${_alias['pedido']}
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
      INNER JOIN ${Setup.PEDIDO_TABLE} ON 
        ${Setup.PEDIDO_TABLE}.${Setup.COLUMN_PEDIDO['idInventario']}= 
        ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['id']}
      WHERE ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']}=$idCliente
        AND ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['id']}=$idProducto
      ORDER BY ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']}
      """);
      return List.generate(
          list.length,
          (i) => {
                'fecha': list[i]['fecha'],
                'producto': list[i]['producto'],
                'pedido': list[i]['pedido']
              });
    } catch (e) {
      print('Select en inventario' + e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  static Future<List<Map<String, dynamic>>> readProductOnly(
      int idCliente) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.rawQuery("""
        SELECT 
        (${Setup.PEDIDO_TABLE}.${Setup.COLUMN_PEDIDO['fechaPedido']}) AS ${_alias['fecha']},
        ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['id']} AS ${_alias['id']},
        ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']} AS ${_alias['producto']},
        ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['precio']} AS ${_alias['precio']},
        ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['cantidad']} AS ${_alias['cantidad']}
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
        INNER JOIN ${Setup.PEDIDO_TABLE} 
          ON ${Setup.PEDIDO_TABLE}.${Setup.COLUMN_PEDIDO['idInventario']}=
            ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['id']}
        WHERE ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']}=$idCliente
        GROUP BY ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']}
        ORDER BY ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']} ASC
        """);
      return List.generate(
          list.length,
          (i) => {
                'fecha': list[i]['fecha'],
                'id': list[i]['id'],
                'producto': list[i]['producto'],
                'precio': list[i]['precio'],
                'cantidad': list[i]['cantidad']
              });
    } catch (e) {
      print('Select en inventario' + e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  static Future<bool> isInventario(int idCliente) async {
    Database db = await Crud.conectar();
    List<Map<String, dynamic>> list = await db.query(Setup.INVENTARIO_TABLE,
        columns: [Setup.COLUMN_INVENTARIO['idCliente']],
        where: "${Setup.COLUMN_INVENTARIO['idCliente']} = $idCliente");
    return list.length > 0 ? true : false;
  }

  static Future<bool> deleteInventario(int idCliente) async {
    Database db = await Crud.conectar();
    try {
      await db.transaction((txn) async {
        List _idInventario = await txn.query(Setup.INVENTARIO_TABLE,
            columns: ['id'],
            where:
                "${Setup.COLUMN_INVENTARIO['idCliente']} = $idCliente AND ${Setup.COLUMN_INVENTARIO['fecha']} = '$fechaHoy'");
        for (int i = 0; i < _idInventario.length; i++) {
          await txn.delete(Setup.PEDIDO_TABLE,
              where:
                  "${Setup.COLUMN_PEDIDO['idInventario']} = ${_idInventario[i]['id']}");
          await txn.delete(Setup.INVENTARIO_PRODUCTO_TABLE,
              where:
                  "${Setup.COLUMN_INVENTARIO_PRODUCTO['idInventario']} = ${_idInventario[i]['id']}");
          await txn.delete(Setup.INVENTARIO_TABLE,
              where:
                  "${Setup.COLUMN_INVENTARIO['id']} = ${_idInventario[i]['id']}");
        }
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      db.close();
    }
  }
}
