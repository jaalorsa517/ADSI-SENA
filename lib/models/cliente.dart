import 'package:ventas/models/conexion.dart';

class Cliente extends Conexion implements Crud {
  //int id1;
  //String id;
  String nombre;
  String representante;
  String telefono;
  //String email;
  //String direccion;

  Cliente(
      [//this.id1,
      //this.id,
      this.nombre,
      this.representante,
      this.telefono,
      //this.email,
      //this.direccion
      ]);

  Cliente.fromMap(Map<String, dynamic> map) {
    //this.id1 = map['id1'];
    //this.id = map['id'];
    this.nombre = map['nombre'];
    this.representante = map['representante'];
    this.telefono = map['telefono'];
    //this.email = map['email'];
    //this.direccion = map['direccion'];
  }

  @override
  bool actualizar() {
    // TODO: implement actualizar
    return null;
  }

  @override
  bool borrar() {
    // TODO: implement borrar
    return null;
  }

  @override
  bool insertar(objeto) {
    // TODO: implement insertar
    return null;
  }

  @override
  Future<List> select() => null;

  Future<List> selectForCiudad(String ciudad) async {
    List l = await this
        .db
        .rawQuery('''SELECT cliente.nombre,cliente.representante,cliente.telefono 
        FROM 
        ((cliente INNER JOIN ciudad_cliente ON cliente.id1=ciudad_cliente.idCliente )
        INNER JOIN ciudad ON ciudad_cliente.idCiudad=ciudad.id) 
        WHERE ciudad.nombre='${ciudad}';''');
    List<Cliente> _query = [];
    l.forEach((d) => _query.add(Cliente.fromMap(d)));
    return _query;
  }
}
