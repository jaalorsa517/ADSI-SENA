import 'package:flutter/foundation.dart';
import 'package:ventas/models/producto/producto.dart';
import 'package:ventas/models/producto/productos.dart';

class ProductoProvider with ChangeNotifier {
  List<Producto> _productos = [];
  get productos => _productos;
  set(client) {
    _productos = client;
    notifyListeners();
  }

  ClienteProvider() {
    loadProductos();
    print('Constructor ${this._productos}');
  }

  void loadProductos() async {
    _productos = await Productos.read();
    print('asincronico ${_productos[0].nombre}');
    notifyListeners();
  }
}
