import 'package:ventas/models/conexion.dart';

class Pedido implements Conexion{
  int id;
  String fecha_pedido;
  String fecha_entrega;
  int id_producto;
  int cantidad;
  int valor;
  int fk_id_cliente;
  Pedido(
      [this.id,
      this.fecha_pedido,
      this.fecha_entrega,
      this.id_producto,
      this.cantidad,
      this.valor,
      this.fk_id_cliente]);

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
