import 'package:flutter/foundation.dart';
import 'package:ventas/config/utilidades.dart';
import 'package:ventas/models/venta/inventario/inventario.dart';
import 'package:ventas/models/venta/inventario/inventarios.dart';

class InventarioProvider extends ChangeNotifier {
  Inventario _inventarioModel; //Manejo del modelo Inventario
  List<Map<String, dynamic>>
      _inventario; //Atributo que cargara los datos a mostrar en la tabla.
  Map<String, dynamic> _historial; // Atributo que mostrara la info en la card

  InventarioProvider() {
    _inventarioModel = Inventario();
    _inventario = List<Map<String, dynamic>>();
    _inventario.add({'fecha': '0', 'producto': '', 'cantidad': 0});
    _historial = {
      'producto': '',
      'cantidad1': 0,
      'cantidad2': 0,
      'cantidad3': 0
    };
  }

  /**** Propiedades del inventario ****/
  List getInventario() => _inventario;

  void addInventario(String fecha, String producto, int cantidad) {
    _inventario
        .add({'fecha': fecha, 'producto': producto, 'cantidad': cantidad});
    this._sortInventario();
    notifyListeners();
  }

  void setInventario(int index, String fecha, String producto, int cantidad) {
    _inventario[index]['fecha'] = fecha;
    _inventario[index]['producto'] = producto;
    _inventario[index]['cantidad'] = cantidad;
    this._sortInventario();
    notifyListeners();
  }

  int findIndexInventario(String producto) {
    int index;
    for (int i = 0; i < _inventario.length; i++) {
      if (_inventario[i]['producto'] == producto) {
        index = i;
        break;
      }
    }
    return index;
  }

  void deleteInventario(int index) {
    _inventario.removeAt(index);
    if (_inventario.length == 0) {
      _inventario.add({'fecha': '0', 'producto': '', 'cantidad': 0});
    }
    notifyListeners();
  }

  /**** Propiedades del historial ****/
  Map getHistorial() => _historial;

  void setHistorial(
      {String producto, String cantidad1, String cantidad2, String cantidad3}) {
    if (producto != null) _historial['producto'] = producto;
    if (cantidad1 != null) _historial['cantidad1'] = cantidad1;
    if (cantidad2 != null) _historial['cantidad2'] = cantidad2;
    if (cantidad3 != null) _historial['cantidad3'] = cantidad3;
    notifyListeners();
  }

  void _sortInventario() {
    List _names = _inventario.map((v) => v['producto']).toList();
    _names.sort();
    List<Map<String, dynamic>> aux = List();
    for (int i = 0; i < _names.length; i++) {
      aux.add(_inventario[this.findIndexInventario(_names[i])]);
    }
    _inventario = aux;
  }
}
