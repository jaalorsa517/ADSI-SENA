import "conexion.dart";

class Inventario extends Conexion implements Crud{

  int id;
  int cantidad;
  DateTime fecha;
  int id_cliente;
  
  Inventario([this.id,this.cantidad,this.fecha,this.id_cliente]);

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
  Future<List> select() {
    // TODO: implement select
    return null;
  }

}