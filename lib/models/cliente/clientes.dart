import 'package:sqflite/sqflite.dart';
import 'package:ventas/config/setup.dart';
import 'package:ventas/models/cliente/cliente.dart';
import 'package:ventas/models/crud.dart';

/// Clase driver del modelo cliente

class Clientes {
  static const Map<String, String> alias = {
    'id': 'id',
    'nit': 'nit',
    'nom': 'nombre',
    'admin': 'admin',
    'dir': 'direccion',
    'tel': 'telefono',
    'email': 'email',
    'ciudad': 'ciudad',
  };

  static Future<bool> create(Cliente cliente) async {
    Database db = await Crud.conectar();
    try {
      await db.rawInsert("INSERT INTO ${Setup.CLIENTE_TABLE} " +
          "(${Setup.COLUMN_CLIENTE['nit']},${Setup.COLUMN_CLIENTE['nombre']}," +
          "${Setup.COLUMN_CLIENTE['admin']},${Setup.COLUMN_CLIENTE['telefono']}," +
          "${Setup.COLUMN_CLIENTE['email']},${Setup.COLUMN_CLIENTE['direccion']}) " +
          "VALUES('${cliente.nit}','${cliente.nombre}','${cliente.representante}'," +
          "'${cliente.telefono}','${cliente.email}','${cliente.direccion}')");
      await db.rawInsert("INSERT INTO ${Setup.CIUDAD_CLIENTE_TABLE} " +
          "VALUES ((SELECT ${Setup.COLUMN_CLIENTE['id']} FROM ${Setup.CLIENTE_TABLE} " +
          "WHERE ${Setup.COLUMN_CLIENTE['nombre']}= \'${cliente.nombre}\')," +
          "(SELECT ${Setup.COLUMN_CIUDAD['id']} FROM ${Setup.CIUDAD_TABLE} " +
          "WHERE ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD['nombre']}=\'${cliente.ciudad}\'))");

      return true;
    } catch (e) {
      print('Nuevo en cliente ' + e.toString());
      return false;
    } finally {
      db.close();
    }
  }

  static Future<List<Cliente>> read() async {
    Database db = await Crud.conectar();

    try {
      List<Map<String, dynamic>> list = await db.rawQuery("""
      SELECT ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']} as ${alias['id']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['nit']} as ${alias['nit']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['nombre']} as ${alias['nom']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['admin']} as ${alias['admin']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['direccion']} as ${alias['dir']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['telefono']} as ${alias['tel']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['email']} as ${alias['email']},
        ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD['nombre']} as ${alias['ciudad']} 
      FROM ${Setup.CLIENTE_TABLE} 
      JOIN ${Setup.CIUDAD_CLIENTE_TABLE} 
        ON ${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE['idCliente']} = 
          ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']} 
      JOIN ${Setup.CIUDAD_TABLE} 
        ON   ${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE['idCiudad']} = 
          ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD['id']} 
      ORDER BY ${alias['ciudad']}
      """);
      return _mapToCliente(list);
    } catch (e) {
      print('Metodo read en cliente ' + e.toString());
      return null;
    } finally {
      db.close();
    }
  }

  static Future<List<Cliente>> readByName(String nameCliente) async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list = await db.rawQuery("""
      SELECT ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']} as ${alias['id']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['nit']} as ${alias['nit']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['nombre']} as ${alias['nom']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['admin']} as ${alias['admin']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['direccion']} as ${alias['dir']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['telefono']} as ${alias['tel']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['email']} as ${alias['email']},
        ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD['nombre']} as ${alias['ciudad']} 
      FROM ${Setup.CLIENTE_TABLE} 
      JOIN ${Setup.CIUDAD_CLIENTE_TABLE} 
        ON ${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE['idCliente']} = 
          ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']} 
      JOIN ${Setup.CIUDAD_TABLE} 
        ON   ${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE['idCiudad']} = 
          ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD['id']} 
      WHERE ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['nombre']} LIKE\'%$nameCliente%\'
      ORDER BY ${alias['ciudad']}
      """);
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
    try {
      List<Map<String, dynamic>> list = await db.rawQuery("""
      SELECT ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']} as ${alias['id']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['nit']} as ${alias['nit']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['nombre']} as ${alias['nom']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['admin']} as ${alias['admin']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['direccion']} as ${alias['dir']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['telefono']} as ${alias['tel']},
        ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['email']} as ${alias['email']},
        ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD['nombre']} as ${alias['ciudad']} 
      FROM ${Setup.CLIENTE_TABLE} 
      JOIN ${Setup.CIUDAD_CLIENTE_TABLE} 
        ON ${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE['idCliente']} = 
          ${Setup.CLIENTE_TABLE}.${Setup.COLUMN_CLIENTE['id']} 
      JOIN ${Setup.CIUDAD_TABLE} 
        ON   ${Setup.CIUDAD_CLIENTE_TABLE}.${Setup.COLUMN_CIUDAD_CLIENTE['idCiudad']} = 
          ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD['id']} 
      WHERE ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD['nombre']}=\'$nameCity\' 
      ORDER BY ${alias['ciudad']}
          """);
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
      await db.rawUpdate("""
          UPDATE ${Setup.CLIENTE_TABLE} 
          SET ${Setup.COLUMN_CLIENTE['nit']}='${cliente.nit}',
            ${Setup.COLUMN_CLIENTE['nombre']}='${cliente.nombre}', 
            ${Setup.COLUMN_CLIENTE['admin']}='${cliente.representante}', 
            ${Setup.COLUMN_CLIENTE['telefono']}='${cliente.telefono}', 
            ${Setup.COLUMN_CLIENTE['email']}='${cliente.email}', 
            ${Setup.COLUMN_CLIENTE['direccion']}='${cliente.direccion}' 
          WHERE ${Setup.COLUMN_CLIENTE['id']}=${cliente.id} 
          """);
      await db.rawUpdate("""
        UPDATE ${Setup.CIUDAD_CLIENTE_TABLE} 
        SET ${Setup.COLUMN_CIUDAD_CLIENTE['idCiudad']}=
          (SELECT ${Setup.COLUMN_CIUDAD['id']} 
            FROM ${Setup.CIUDAD_TABLE} 
            WHERE ${Setup.CIUDAD_TABLE}.${Setup.COLUMN_CIUDAD['nombre']}=
            \'${cliente.ciudad}\') 
        WHERE ${Setup.COLUMN_CIUDAD_CLIENTE['idCliente']}=${cliente.id}
        """);
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
      await db.delete(Setup.CIUDAD_CLIENTE_TABLE,
          where: '${Setup.COLUMN_CIUDAD_CLIENTE['idCliente']}=$idCliente');
      await db.delete(Setup.CLIENTE_TABLE,
          where: '${Setup.COLUMN_CLIENTE['id']} =$idCliente');
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
      cliente.id = element[alias['id']];
      cliente.nit = element[alias['nit']];
      cliente.nombre = element[alias['nom']];
      cliente.representante = element[alias['admin']];
      cliente.telefono = element[alias['tel']];
      cliente.email = element[alias['email']];
      cliente.direccion = element[alias['dir']];
      cliente.ciudad = element['ciudad'];
      clientes.add(cliente);
    });
    return clientes;
  }
}
