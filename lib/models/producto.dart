import 'package:ventas/models/conexion.dart';

class Producto extends Conexion implements Crud {
  String TABLE = 'producto';
  int id;
  String nombre;
  int precio;

  Producto([this.id, this.nombre, this.precio]);
  
  Producto.fromMap(Map<String,dynamic> map){
    this.id=map['id'];
    this.nombre=map['nombre'];
    this.precio =map ['precio'];
  }

  @override
  Future <List<Producto>> select() async{
    List _list;
    try{
    _list= await this.db.rawQuery("Select * from producto;");
    }
    catch(Exception){
      print(Exception.toString());
    }
    // [{nom:dato,nom2:dato2},{nom:dato,nom2:dato2}]
    List <Producto>_query=[];
    for (int i=0;i<_list.length;i++){
      _query.add(Producto.fromMap(_list[i]));
    }
    return _query;
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
  bool insertar(producto) {
    try {
      this.db.insert(producto.TABLE, producto.toMap());
      return true;
    } catch (Exception) {
      this.mensaje = 'Error al insertar';
      return false;
    }
  }
}
