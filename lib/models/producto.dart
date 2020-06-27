import 'package:ventas/models/conexion.dart';

class Producto extends Conexion  {
  String TABLE = 'producto';
  int id;
  String nombre;
  int precio;
  int iva;

  Producto([this.id, this.nombre, this.precio, this.iva]);

  Producto.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nombre = map['nombre'];
    this.precio = map['precio'];
  }

}
