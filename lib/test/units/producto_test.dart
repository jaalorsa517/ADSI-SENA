import 'package:edertiz/models/producto/producto.dart';
import 'package:edertiz/models/producto/productos.dart';

class Producto_test {
  Producto_test() {
    print("TESTING ON MODULE PRODUCTO");
  }

  Future<void> start() async {
    await crea();
    await muestra();
    await actualiza();
    await elimina();
    print("FINISHED TESTING ON MODULE PRODUCTO");
  }

  void crea() async {
    print("TESTING CREATE");
    bool result = await Productos.create(Producto(null,"Leche",1200,19));
    print(result ? "TEST APROBADO" : "TEST NO APROBADO");
  }

  void muestra() async {
    print("TESTING READ");
    List result = await Productos.read();
    print(result != null ? "TEST APROBADO" : "TEST NO APROBADO");
  }

  void actualiza() async {
    print("TESTING UPDATE");
    bool result =
        await Productos.update(Producto(await Productos.getId(), "Crema de leche", 4000,12));
    print(result ? "TEST APROBADO" : "TEST NO APROBADO");
  }

  void elimina() async {
    print("TESTING DELETE");
    bool result = await Productos.delete(await Productos.getId());
    print(result ? "TEST APROBADO" : "TEST NO APROBADO");
  }
}
