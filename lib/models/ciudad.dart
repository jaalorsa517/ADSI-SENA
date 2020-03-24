import "conexion.dart";

class Ciudad extends Conexion implements Crud {
  int id;
  String nombre;

  Ciudad([this.id, this.nombre]);

  Ciudad.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nombre = map['nombre'];
  }

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
  Future<List> select() async {
    List l = await this.db.rawQuery("SELECT * FROM ciudad");
    List<Ciudad> _query = [];
    l.forEach((d) => _query.add(Ciudad.fromMap(d)));
    return _query;
  }
}