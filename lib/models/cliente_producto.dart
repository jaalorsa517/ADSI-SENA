import 'conexion.dart';

class Cliente_Producto extends Conexion {
  final int id;
  final int id_producto;
  final int id_cliente;

  Cliente_Producto([this.id, this.id_producto, this.id_cliente]);
}
