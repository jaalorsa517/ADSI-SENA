import 'package:sqflite/sqflite.dart';
import 'package:ventas/config/setup.dart';
import 'package:ventas/models/cliente/cliente.dart';
import 'package:ventas/models/crud.dart';

/**
 * Clase driver del modelo cliente
 */

class Clientes implements Crud {
  static Future<bool> create(Cliente cliente) async {
    Database db = await Crud.conectar();
    try {
      db.insert(Setup.CLIENT_TABLE, _clienteToMap(cliente));
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<List<Cliente>> read() async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.query(Setup.CLIENT_TABLE);
      return _mapToCliente(list);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<List<Cliente>> readById(int idCliente) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.query(Setup.CLIENT_TABLE,
          where: '${Setup.COLUMN_CLIENTE[0]}= $idCliente');
      return _mapToCliente(list);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<List<Cliente>> readByName(String nameCliente) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.query(Setup.CLIENT_TABLE,
          where: '${Setup.COLUMN_CLIENTE[2]} = $nameCliente');
      return _mapToCliente(list);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<bool> update(Cliente cliente) async {
    Database db = await Crud.conectar();
    try {
      db.update(Setup.CLIENT_TABLE, _clienteToMap(cliente));
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> delete(int idObject) async {
    Database db = await Crud.conectar();
    try {
      db.delete(Setup.CLIENT_TABLE, where: 'id=$idObject');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static List<Cliente> _mapToCliente(List<Map<String, dynamic>> list) {
    List<Cliente> clientes = [];
    list.forEach((element) {
      Cliente cliente = Cliente();
      cliente.id = element[Setup.COLUMN_CLIENTE[0]];
      cliente.nit = element[Setup.COLUMN_CLIENTE[1]];
      cliente.nombre = element[Setup.COLUMN_CLIENTE[2]];
      cliente.representante = element[Setup.COLUMN_CLIENTE[3]];
      cliente.telefono = element[Setup.COLUMN_CLIENTE[4]];
      cliente.email = element[Setup.COLUMN_CLIENTE[5]];
      cliente.direccion = element[Setup.COLUMN_CLIENTE[6]];
      clientes.add(cliente);
    });
    return clientes;
  }

  static Map<String, dynamic> _clienteToMap(Cliente cliente) {
    Map<String, dynamic> mapCliente = {};
    mapCliente[Setup.COLUMN_CLIENTE[1]] = cliente.nit;
    mapCliente[Setup.COLUMN_CLIENTE[2]] = cliente.nombre;
    mapCliente[Setup.COLUMN_CLIENTE[3]] = cliente.representante;
    mapCliente[Setup.COLUMN_CLIENTE[4]] = cliente.telefono;
    mapCliente[Setup.COLUMN_CLIENTE[5]] = cliente.email;
    mapCliente[Setup.COLUMN_CLIENTE[6]] = cliente.direccion;
    return mapCliente;
  }
}
