import "conexion.dart";

class Ciudad {
  int id;
  String nombre;

  Ciudad([this.id, this.nombre]);

  Ciudad.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nombre = map['nombre'];
  }
}


class Ciudades extends Conexion implements Crud{
  String _TABLE='ciudad';

  @override
  Future<List> select() async {
    List<Ciudad> _ciudades=[];
    if(this.db !=null){
      List _query= await this.db.query(this._TABLE);
      _query.forEach((d)=>_ciudades.add(Ciudad.fromMap(d)));
      return _ciudades;
    }
    else{
      return null;
    }
  }
 
}