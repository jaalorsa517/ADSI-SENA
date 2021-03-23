import 'package:edertiz/logic/producto/producto_provider.dart';
import 'package:edertiz/models/producto/producto.dart';

class IntegracionProducto {
  ProductoProvider _producto;
  IntegracionProducto() {
    print("INICIO PRUEBAS INTEGRACION MODULO PRODUCTO");

    this._producto = new ProductoProvider();
    this._producto.producto = new Producto(null, "Leche", 1200, 19);
  }

  Future<void> start() async {
    await crearProducto();
    await modificarProducto();
    await eliminarProducto();
    print("FIN PRUEBAS INTEGRACION MODULO PRODUCTO");
  }

  Future<void> crearProducto() async {
    print("INTEGRACION CREAR PRODUCTO");
    bool result = await this._producto.productoCrear();
    if (result) {
      await this._producto.loadProducto();
      this._producto.producto = this._producto.productos[0];
      print("TEST INTEGRACION CREAR APROBO");
    } else {
      print("TEST INTEGRACION CREAR FALLO");
    }
  }

  Future<void> modificarProducto() async {
    print("INTEGRACION MODIFICAR PRODUCTO");
    bool result = await this._producto.productoModificar();
    print(result
        ? "TEST INTEGRACION MODIFICAR APROBO"
        : "TEST INTEGRACION MODIFICAR FALLO");
  }

  Future<void> eliminarProducto() async {
    print("INTEGRACION ELIMINAR PRODUCTO");
    bool result =
        await this._producto.productoBorrar(this._producto.producto.id);
    print(result
        ? "TEST INTEGRACION ELIMINAR APROBO"
        : "TEST INTEGRACION ELIMINAR FALLO");
  }
}
