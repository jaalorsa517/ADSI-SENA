import "conexion.dart";

class Ciudad_Cliente extends Conexion {
  int idCiudad;
  int idCliente;

  Ciudad_Cliente([this.idCiudad, this.idCliente]);

  Ciudad_Cliente.fromMap(Map<String, dynamic> map) {
    this.idCiudad = map['idCiudad'];
    this.idCliente = map['idCliente'];
  }
}
