import 'package:sqflite/sqflite.dart';
import 'package:ventas/config/setup.dart';
import 'package:ventas/models/crud.dart';
import 'package:ventas/models/venta/historial/pedidio_historial.dart';
import 'package:ventas/models/venta/pedido/pedido.dart';

class Pedidos {
  static const Map<String, String> _alias = {
    'id': 'id',
    'fechaPedido': 'fechaPedido',
    'fechaEntrega': 'fechaEntrega',
    'idInventario': 'idInventario',
    'cantidad': 'cantidad',
    'valor': 'valor',
    'idCliente': 'idCliente',
    'cliente': 'cliente',
    'fecha': 'fecha',
    'producto': 'producto'
  };

  static Future<bool> create(Pedido pedido) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> _id = await db.rawQuery("""
      SELECT ${Setup.COLUMN_PEDIDO['id']} AS ${_alias['id']} 
      FROM ${Setup.PEDIDO_TABLE} 
      ORDER BY ${Setup.COLUMN_PEDIDO['id']} DESC 
      LIMIT 1
      """);
      pedido.id = _id[0][_alias['id']] + 1 ?? 1;
      await db.insert(Setup.PEDIDO_TABLE, _pedidoToMap(pedido));
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static Future<List<PedidoHistorial>> readHistoryGeneral(int idCliente) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.rawQuery("""
      SELECT ${Setup.PEDIDO_TABLE}.${Setup.COLUMN_PEDIDO['fechaPedido']} AS ${_alias['fecha']},
        ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']} AS ${_alias['producto']},
        ${Setup.PEDIDO_TABLE}.${Setup.COLUMN_PEDIDO['cantidad']} AS ${_alias['cantidad']}
      FROM ${Setup.PEDIDO_TABLE}
      INNER JOIN ${Setup.INVENTARIO_TABLE} 
        ON ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['id']} =
          ${Setup.PEDIDO_TABLE}.${Setup.COLUMN_PEDIDO['id']} 
      INNER JOIN ${Setup.CLIENTE_TABLE} 
        ON ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['idCliente']} =
          ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']}
      INNER JOIN ${Setup.INVENTARIO_PRODUCTO_TABLE} 
        ON ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['idInventario']}=
          ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['id']}
      INNER JOIN ${Setup.PRODUCTO_TABLE} 
        ON ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['id']}=
          ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['idProducto']}
      WHERE ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']}=$idCliente
      ORDER BY ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']} ASC
      """);
      return _mapToPedidoHistorial(list);
    } catch (e) {
      print('Select en pedido' + e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  static Future<List<PedidoHistorial>> readHistoryProducto(
      int idCliente, int idProducto) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.rawQuery("""
      SELECT ${Setup.PEDIDO_TABLE}.${Setup.COLUMN_PEDIDO['fechaPedido']} AS ${_alias['fecha']},
        ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']} AS ${_alias['producto']},
        ${Setup.PEDIDO_TABLE}.${Setup.COLUMN_PEDIDO['cantidad']} AS ${_alias['cantidad']}
      FROM ${Setup.PEDIDO_TABLE}
      INNER JOIN ${Setup.INVENTARIO_TABLE} 
        ON ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['id']} =
          ${Setup.PEDIDO_TABLE}.${Setup.COLUMN_PEDIDO['id']} 
      INNER JOIN ${Setup.CLIENTE_TABLE} 
        ON ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['idCliente']} =
          ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']}
      INNER JOIN ${Setup.INVENTARIO_PRODUCTO_TABLE} 
        ON ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['idInventario']}=
          ${Setup.INVENTARIO_TABLE}.${Setup.COLUMN_INVENTARIO['id']}
      INNER JOIN ${Setup.PRODUCTO_TABLE} 
        ON ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['id']}=
          ${Setup.INVENTARIO_PRODUCTO_TABLE}.${Setup.COLUMN_INVENTARIO_PRODUCTO['idProducto']}
      WHERE ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']}=$idCliente
        AND ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['id']}=$idProducto
      ORDER BY ${Setup.PRODUCTO_TABLE}.${Setup.COLUMN_PRODUCTO['nombre']} ASC
      """);
      return _mapToPedidoHistorial(list);
    } catch (e) {
      print('Select en pedido' + e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  static Future<List<PedidoHistorial>> readInventaryDate(
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
      return _mapToPedidoHistorial(list);
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

  static Future<bool> update(Pedido pedido) async {
    Database db = await Crud.conectar();
    try {
      await db.update(Setup.PEDIDO_TABLE, _pedidoToMap(pedido),
          where: '${Setup.COLUMN_PEDIDO['id']}= pedido.id');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static Future<bool> delete(int idPedido) async {
    Database db = await Crud.conectar();
    try {
      await db.delete(Setup.PEDIDO_TABLE,
          where: '${Setup.COLUMN_PEDIDO['id']}=$idPedido');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static Map<String, dynamic> _pedidoToMap(Pedido pedido) {
    Map<String, dynamic> _pedido = {};
    _pedido[Setup.COLUMN_PEDIDO['id']] = pedido.id;
    _pedido[Setup.COLUMN_PEDIDO['fechaPedido']] = pedido.fechaPedido;
    _pedido[Setup.COLUMN_PEDIDO['fechaEntrega']] = pedido.fechaEntrega;
    _pedido[Setup.COLUMN_PEDIDO['idInventario']] = pedido.idInventario;
    _pedido[Setup.COLUMN_PEDIDO['cantidad']] = pedido.cantidad;
    _pedido[Setup.COLUMN_PEDIDO['valor']] = pedido.valor;

    return _pedido;
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

  static List<PedidoHistorial> _mapToPedidoHistorial(
      List<Map<String, dynamic>> list) {
    List<PedidoHistorial> _list = [];
    list.forEach((element) {
      PedidoHistorial history = PedidoHistorial();
      history.fechaPedido = element[_alias['fecha']];
      history.nombreProducto = element[_alias['producto']];
      history.cantidad = element[_alias['cantidad']];
      _list.add(history);
    });
    return _list;
  }
}
