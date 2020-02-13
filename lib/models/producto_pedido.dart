import 'conexion.dart';

class Producto_Pedido implements Conexion{
  int id;
  int id_producto;
  int id_pedido;
  Producto_Pedido([this.id, this.id_producto, this.id_pedido]);

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
