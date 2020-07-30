import 'package:flutter/foundation.dart';
import 'package:ventas/models/producto/producto.dart';
import 'package:ventas/models/producto/productos.dart';

class ProductoProvider extends ChangeNotifier {
  List<Producto> _productos = [];
  Producto _producto;

  get productos => _productos;
  set productos(product) {
    _productos = product;
    notifyListeners();
  }

  get producto => _producto;
  set producto(product) {
    _producto = product;
    notifyListeners();
  }

  ProductoProvider() {
    loadProducto();
    nuevoProducto();
  }

  void nuevoProducto() {
    producto = new Producto();
  }

  Future<void> loadProducto() async {
    productos = await Productos.read();
    productos = productos ?? [];
  }

  void updateCliente(
    String nombre,
    int precio,
    double iva,
  ) {
    _producto.nombre = nombre;
    _producto.precio = precio;
    _producto.iva = iva;
    notifyListeners();
  }

  /* Future<void> productoForId(int id) async {
    productos = await Productos.readById(id);
  } */

  Future<void> productoForName(String name) async {
    productos = await Productos.readByName(name);
  }

  Future<bool> productoCrear() async {
    bool respuesta = await Productos.create(_producto) ? true : false;
    if (respuesta) await loadProducto();
    return respuesta;
  }

  Future<bool> productoModificar() async {
    bool respuesta = await Productos.update(_producto) ? true : false;
    if (respuesta) await loadProducto();
    return respuesta;
  }

  Future<bool> productoBorrar(int id) async {
    bool respuesta = await Productos.delete(id) ? true : false;
    if (respuesta) await loadProducto();
    return respuesta;
  }
}
