import 'package:ventas/models/conexion.dart';

class Producto implements Conexion {
  int id;
  String nombre;
  int precio;
  Producto([this.id, this.nombre, this.precio]);

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
