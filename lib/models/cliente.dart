import 'package:ventas/models/conexion.dart';

class Cliente extends Conexion{
  final int id1;
  final int id;
  final String nombre;
  final String representante;
  final String telefono;
  final String email;

  Cliente(
      [this.id1,
      this.id,
      this.nombre,
      this.representante,
      this.telefono,
      this.email]);
}
