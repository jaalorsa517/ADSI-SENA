import 'package:ventas/models/conexion.dart';

class Cliente implements Conexion{
  int id1;
  int id;
  String nombre;
  String representante;
  String telefono;
  String email;
  Cliente(
      [this.id1,
      this.id,
      this.nombre,
      this.representante,
      this.telefono,
      this.email]);

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
  bool conectar() {
    // TODO: implement conectar
    return null;
  }

  @override
  bool desconectar() {
    // TODO: implement desconectar
    return null;
  }

  @override
  bool insertar() {
    // TODO: implement insertar
    return null;
  }

  @override
  List select() {
    // TODO: implement select
    return null;
  }
}
