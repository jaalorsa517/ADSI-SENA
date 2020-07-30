import 'package:sqflite/sqflite.dart';
import 'package:ventas/config/setup.dart';
import 'package:ventas/models/cliente/cliente.dart';
import 'package:ventas/models/crud.dart';

/// Clase driver del modelo cliente

class Clientes implements Crud {
  static Future<bool> create(Cliente cliente) async {
    Database db = await Crud.conectar();
    String sentence = '';
    for (int i = 1; i < Setup.COLUMN_CLIENTE.length; i++) {
      sentence += '${Setup.COLUMN_CLIENTE[i]} ,';
    }
    sentence = sentence.substring(0, sentence.length - 1);
    try {
      await db.rawInsert("INSERT INTO ${Setup.CLIENT_TABLE} " +
          "(${Setup.COLUMN_CLIENTE[1]},${Setup.COLUMN_CLIENTE[2]}," +
          "${Setup.COLUMN_CLIENTE[3]},${Setup.COLUMN_CLIENTE[4]}," +
          "${Setup.COLUMN_CLIENTE[5]},${Setup.COLUMN_CLIENTE[6]}) " +
          "VALUES('${cliente.nit}','${cliente.nombre}','${cliente.representante}'," +
          "'${cliente.telefono}','${cliente.email}','${cliente.direccion}')");
      await db.rawInsert("INSERT INTO ${Setup.CIUDAD_CLIENTE_TABLE} " +
          "VALUES ((SELECT ${Setup.COLUMN_CLIENTE[0]} FROM ${Setup.CLIENT_TABLE} " +
          "WHERE ${Setup.COLUMN_CLIENTE[2]}= \'${cliente.nombre}\')," +
          "(SELECT ${Setup.COLUMN_CIUDAD[0]} FROM ${Setup.CIUDAD_TABLE} " +
          "WHERE ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[1]}=\'${cliente.ciudad}\'))");

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static Future<List<Cliente>> read() async {
    Database db = await Crud.conectar();
    String sentence = '';
    Setup.COLUMN_CLIENTE
        .forEach((column) => sentence += '${Setup.CLIENT_TABLE}.$column,');
    sentence += '${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[1]} AS ciudad ';
    try {
      List<Map<String, dynamic>> list = await db.rawQuery('SELECT $sentence' +
          'FROM ${Setup.CLIENT_TABLE} ' +
          'JOIN ${Setup.CIUDAD_CLIENTE_TABLE} ' +
          'ON ${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE[0]} = ' +
          '${Setup.CLIENT_TABLE}.${Setup.COLUMN_CLIENTE[0]} ' +
          'JOIN ${Setup.CIUDAD_TABLE} ' +
          'ON   ${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE[1]} = ' +
          '${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[0]} ' +
          'ORDER BY ciudad');
      return _mapToCliente(list);
    } catch (e) {
      print('Metodo read en cliente ' + e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  /* static Future<List<Cliente>> readById(int idCliente) async {
    Database db = await Crud.conectar();
    String sentence = '';
    Setup.COLUMN_CLIENTE
        .forEach((column) => sentence += '${Setup.CLIENT_TABLE}.$column,');
    sentence += '${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[1]} AS ciudad ';
    try {
      List<Map<String, dynamic>> list = await db.rawQuery('SELECT $sentence' +
          'FROM ${Setup.CLIENT_TABLE} ' +
          'JOIN ${Setup.CIUDAD_CLIENTE_TABLE} ' +
          'ON ${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE[0]} = ' +
          '${Setup.CLIENT_TABLE}.${Setup.COLUMN_CLIENTE[0]} ' +
          'JOIN ${Setup.CIUDAD_TABLE} ' +
          'ON ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[0]} = ' +
          '${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE[1]} ' +
          'WHERE ${Setup.CLIENT_TABLE}.${Setup.COLUMN_CLIENTE[0]}= $idCliente' +
          'ORDER BY ciudad');
      return _mapToCliente(list);
    } catch (e) {
      print(e.toString());
      return null;
    } finally {
      db.close();
    }
  } */

  static Future<List<Cliente>> readByName(String nameCliente) async {
    Database db = await Crud.conectar();
    String sentence = '';
    Setup.COLUMN_CLIENTE
        .forEach((column) => sentence += '${Setup.CLIENT_TABLE}.$column,');
    sentence += '${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[1]} AS ciudad ';
    try {
      List<Map<String, dynamic>> list = await db.rawQuery('SELECT $sentence' +
          'FROM ${Setup.CLIENT_TABLE} ' +
          'JOIN ${Setup.CIUDAD_CLIENTE_TABLE} ' +
          'ON ${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE[0]} = ' +
          '${Setup.CLIENT_TABLE}.${Setup.COLUMN_CLIENTE[0]} ' +
          'JOIN ${Setup.CIUDAD_TABLE} ' +
          'ON ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[0]} = ' +
          '${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE[1]} ' +
          'WHERE ${Setup.CLIENT_TABLE}.${Setup.COLUMN_CLIENTE[2]} LIKE\'%$nameCliente%\'' +
          'ORDER BY ciudad');
      return _mapToCliente(list);
    } catch (e) {
      print(e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  static Future<List<Cliente>> readByCity(String nameCity) async {
    Database db = await Crud.conectar();
    String sentence = '';
    Setup.COLUMN_CLIENTE
        .forEach((column) => sentence += '${Setup.CLIENT_TABLE}.$column,');
    sentence += '${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[1]} AS ciudad ';
    try {
      List<Map<String, dynamic>> list = await db.rawQuery('SELECT $sentence' +
          'FROM ${Setup.CLIENT_TABLE} ' +
          'JOIN ${Setup.CIUDAD_CLIENTE_TABLE} ' +
          'ON ${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE[0]} = ' +
          '${Setup.CLIENT_TABLE}.${Setup.COLUMN_CLIENTE[0]} ' +
          'JOIN ${Setup.CIUDAD_TABLE} ' +
          'ON ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[0]} = ' +
          '${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE[1]} ' +
          'WHERE ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[1]}=\'$nameCity\'' +
          'ORDER BY ciudad');
      return _mapToCliente(list);
    } catch (e) {
      print(e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  static Future<bool> update(Cliente cliente) async {
    Database db = await Crud.conectar();
    try {
      await db.rawUpdate(
          "UPDATE ${Setup.CLIENT_TABLE} SET ${Setup.COLUMN_CLIENTE[1]}='${cliente.nit}'," +
              "${Setup.COLUMN_CLIENTE[2]}='${cliente.nombre}'" +
              ",${Setup.COLUMN_CLIENTE[3]}='${cliente.representante}'" +
              ",${Setup.COLUMN_CLIENTE[4]}='${cliente.telefono}'," +
              "${Setup.COLUMN_CLIENTE[5]}='${cliente.email}'," +
              "${Setup.COLUMN_CLIENTE[6]}='${cliente.direccion}'" +
              "WHERE ${Setup.COLUMN_CLIENTE[0]}=${cliente.id} ");
      await db.rawUpdate("UPDATE ${Setup.CIUDAD_CLIENTE_TABLE} " +
          "SET ${Setup.COLUMN_CIUDAD_CLIENTE[1]}=(SELECT ${Setup.COLUMN_CIUDAD[0]} " +
          "FROM ${Setup.CIUDAD_TABLE} " +
          "WHERE ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD[1]}='${cliente.ciudad}') " +
          "WHERE ${Setup.COLUMN_CIUDAD_CLIENTE[0]}=${cliente.id}");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static Future<bool> delete(int idCliente) async {
    Database db = await Crud.conectar();
    try {
      await db.delete(Setup.CLIENT_TABLE,
          where: '${Setup.COLUMN_CLIENTE[0]} =$idCliente');
      await db.delete(Setup.CIUDAD_CLIENTE_TABLE,
          where: '${Setup.COLUMN_CIUDAD_CLIENTE[0]}=$idCliente');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static List<Cliente> _mapToCliente(List<Map<String, dynamic>> list) {
    List<Cliente> clientes = [];
    list.forEach((element) {
      Cliente cliente = Cliente();
      cliente.id = element[Setup.COLUMN_CLIENTE[0].toString()];
      cliente.nit = element[Setup.COLUMN_CLIENTE[1]];
      cliente.nombre = element[Setup.COLUMN_CLIENTE[2]];
      cliente.representante = element[Setup.COLUMN_CLIENTE[3]];
      cliente.telefono = element[Setup.COLUMN_CLIENTE[4]];
      cliente.email = element[Setup.COLUMN_CLIENTE[5]];
      cliente.direccion = element[Setup.COLUMN_CLIENTE[6]];
      cliente.ciudad = element['ciudad'];
      clientes.add(cliente);
    });
    return clientes;
  }

  /* static Map<String, dynamic> _clienteToMap(Cliente cliente) {
    Map<String, dynamic> mapCliente = {};
    mapCliente[Setup.COLUMN_CLIENTE[0]] = cliente.id;
    mapCliente[Setup.COLUMN_CLIENTE[1]] = cliente.nit;
    mapCliente[Setup.COLUMN_CLIENTE[2]] = cliente.nombre;
    mapCliente[Setup.COLUMN_CLIENTE[3]] = cliente.representante;
    mapCliente[Setup.COLUMN_CLIENTE[4]] = cliente.telefono;
    mapCliente[Setup.COLUMN_CLIENTE[5]] = cliente.email;
    mapCliente[Setup.COLUMN_CLIENTE[6]] = cliente.direccion;
    mapCliente[Setup.COLUMN_CIUDAD[1]] = cliente.ciudad;
    return mapCliente;
  } */
}
