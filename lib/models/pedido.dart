import 'package:ventas/models/conexion.dart';

/*
SELECT pedido.fecha_pedido as pedido,pedido.fecha_entrega as entrega, 
	producto.nombre as producto, pedido.cantidad, pedido.valor, cliente.nombre as cliente
FROM pedido
INNER JOIN inventario ON pedido.id_inventario=inventario.id
INNER JOIN inventario_producto ON inventario.id=inventario_producto.id_Inventario
INNER JOIN producto ON inventario_producto.id_Producto= producto.id
INNER JOIN cliente ON cliente.id1=inventario.fk_id_cliente
WHERE cliente.id1=5;
*/

class Pedido extends Conexion {
  final int id;
  final String fecha_pedido;
  final String fecha_entrega;
  final int id_inventario;
  final int cantidad;
  final int valor;
  
  Pedido(
      [this.id,
      this.fecha_pedido,
      this.fecha_entrega,
      this.id_inventario,
      this.cantidad,
      this.valor]);
}
