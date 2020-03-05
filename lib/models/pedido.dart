import 'package:ventas/models/conexion.dart';

class Pedido extends Conexion{
  final int id;
  final String fecha_pedido;
  final String fecha_entrega;
  final int id_producto;
  final int cantidad;
  final int valor;
  final int fk_id_cliente;
  Pedido(
      [this.id,
      this.fecha_pedido,
      this.fecha_entrega,
      this.id_producto,
      this.cantidad,
      this.valor,
      this.fk_id_cliente]);
}
