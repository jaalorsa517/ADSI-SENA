import 'package:flutter/foundation.dart';
import 'package:ventas/models/producto/producto.dart';
import 'package:ventas/models/producto/productos.dart';

class ProductoProvider with ChangeNotifier {
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
    loadProductos();
    nuevoProducto();
  }

  void nuevoProducto() {
    _producto = new Producto();
  }

  Future<void> loadProductos() async {
    _productos = await Productos.read();
    notifyListeners();
  }

  Future<void> productoForId(int id) async {
    _productos = [];
    _productos = await Productos.readById(id);
    notifyListeners();
  }

  Future<bool> productoCrear() async {
    bool respuesta = await Productos.create(_producto) ? true : false;
    if (respuesta) await loadProductos();
    return respuesta;
  }

  Future<bool> productoModificar() async {
    bool respuesta = await Productos.update(_producto) ? true : false;
    if (respuesta) await loadProductos();
    return respuesta;
  }

  Future<bool> productoBorrar(int id) async {
    bool respuesta = await Productos.delete(id) ? true : false;
    if (respuesta) await loadProductos();
    return respuesta;
  }
}
