import 'conexion.dart';

class Cliente {
  int id1;
  String identificacion;
  String negocio;
  String nombre;
  String telefono;
  String email;
  String direccion;
  String ciudad;

  Cliente.fromMap(Map<String, dynamic> map) {
    this.id1 = map['id1'] ?? '';
    this.identificacion = map['id'] ?? '';
    this.negocio = map['nombre'] ?? '';
    this.nombre = map['representante'] ?? '';
    this.telefono = map['telefono'] ?? '';
    this.email = map['email'] ?? '';
    this.direccion = map['direccion'] ?? '';
    this.ciudad = map['ciudad'] ?? '';
  }
}

class Clientes extends Conexion implements Crud {
  List<Cliente> _clientes = [];

  @override
  Future<List> select([condicion = '']) async {
    List _clients = [];
    if (this.db != null) {
      if (condicion != '') {
        _clients = await this.db.rawQuery("""
        SELECT cliente.id1,cliente.id,cliente.nombre,cliente.representante,cliente.telefono,
	            cliente.email,cliente.direccion,ciudad.nombre as ciudad
        FROM cliente
        INNER JOIN ciudad_cliente ON cliente.id1=ciudad_cliente.idCliente
        INNER JOIN ciudad ON ciudad_cliente.idCiudad= ciudad.id
        WHERE ciudad.nombre= '${condicion};'
      """);
      } else {
        _clients = await this
            .db
            .rawQuery("""SELECT cliente.id1,cliente.id,cliente.nombre,
        cliente.representante,cliente.telefono,cliente.email,cliente.direccion,
        ciudad.nombre as ciudad FROM cliente 
        INNER JOIN ciudad_cliente ON cliente.id1=ciudad_cliente.idCliente 
        INNER JOIN ciudad ON ciudad_cliente.idCiudad= ciudad.id;""");
      }
      _clients.forEach((d) => this._clientes.add(Cliente.fromMap(d)));
      return this._clientes;
    } else {
      return null;
    }
  }
}
