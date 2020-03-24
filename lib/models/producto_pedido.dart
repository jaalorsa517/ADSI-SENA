import 'conexion.dart';

class Producto_Pedido extends Conexion{
  final int id_producto;
  final int id_pedido;

  Producto_Pedido([this.id_producto, this.id_pedido]);
}
