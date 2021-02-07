import 'package:flutter/foundation.dart';
import 'package:ventas/config/utilidades.dart';
import 'package:ventas/models/venta/inventario/inventario.dart';
import 'package:ventas/models/venta/inventario/inventarios.dart';

class InventarioProvider extends ChangeNotifier {
  Inventario _inventarioModel; //Manejo del modelo Inventario
  List<Map<String, dynamic>>
      _inventario; //Atributo que cargara los datos a mostrar en la tabla.
  Map<String, dynamic> _historial; // Atributo que mostrara la info en la card
  DateTime _fechaEntrega;

  InventarioProvider() {
    _fechaEntrega = DateTime.now();
    _inventarioModel = Inventario();
    _inventario = List<Map<String, dynamic>>();
    _inventario.add({
      'id': null,
      'fecha': fechaHoy,
      'producto': '',
      'cantidad': 0,
      'precio': 0,
      'pedido': 0,
      'fechaEntrega': filterDate(this._fechaEntrega)
    });
    _historial = {
      'producto': '',
      'cantidad1': '0',
      'cantidad2': '0',
      'cantidad3': '0',
      'precio': '',
    };
  }

  /****Propiedad fechaEntrega *****/
  get fechaEntrega => _fechaEntrega;

  set fechaEntrega(DateTime fecha) {
    _fechaEntrega = fecha;
    for (int i = 0; i < _inventario.length; i++) {
      this.setInventario(i, fechaEntrega: filterDate(_fechaEntrega));
    }
    notifyListeners();
  }

  /**** Propiedades del inventario ****/
  List getInventario() => _inventario;

  void addInventario(
      int id, String fecha, String producto, int cantidad, int precio) {
    _inventario.add({
      'id': id,
      'fecha': fecha,
      'producto': producto,
      'cantidad': cantidad,
      'precio': precio,
      'pedido': 0,
      'fechaEntrega': filterDate(_fechaEntrega)
    });
    _inventario.sort((a, b) {
      var aName = a['producto'];
      var bName = b['producto'];
      return aName.compareTo(bName);
    });
    notifyListeners();
  }

  void setInventario(int index,
      {int id,
      String fecha,
      String producto,
      int cantidad,
      int precio,
      int pedido,
      String fechaEntrega}) {
    if (id != null) _inventario[index]['id'] = id;
    if (fecha != null) _inventario[index]['fecha'] = fecha;
    if (producto != null) _inventario[index]['producto'] = producto;
    if (cantidad != null) _inventario[index]['cantidad'] = cantidad;
    if (precio != null) _inventario[index]['precio'] = precio;
    if (pedido != null) _inventario[index]['pedido'] = pedido;
    if (fechaEntrega != null) _inventario[index]['fechaEntrega'] = fechaEntrega;
    _inventario.sort((a, b) {
      var aName = a['producto'];
      var bName = b['producto'];
      return aName.compareTo(bName);
    });
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
      _inventario.add({
        'id': null,
        'fecha': '0',
        'producto': '',
        'cantidad': 0,
        'precio': 0,
        'pedido': 0
      });
    }
    notifyListeners();
  }

  // Propiedades del historial
  Map getHistorial() => _historial;

  Future<void> setHistorial(
      {String producto, String precio, int idCliente, int idProducto}) async {
    _historial['cantidad1'] = '0';
    _historial['cantidad2'] = '0';
    _historial['cantidad3'] = '0';
    if (producto != null) _historial['producto'] = producto;
    if (precio != null) _historial['precio'] = precio;
    if (idCliente != null && idProducto != null) {
      List<Map<String, dynamic>> aux =
          await Inventarios.readHistoryProduct(idCliente, idProducto);
      if (aux != null) {
        //transformar string a fechas para ordenar
        for (int i = 0; i < aux.length; i++) {
          int year = int.parse(aux[i]['fecha'].split("-")[0]);
          int month = int.parse(aux[i]['fecha'].split("-")[1]);
          int day = int.parse(aux[i]['fecha'].split("-")[2]);
          aux[i]['fecha'] = filterDate(DateTime(
            year,
            month,
            day,
          ));
        }
        //ordernar lista por fecha
        aux.sort((a, b) {
          var aDate = a['fecha'];
          var bDate = b['fecha'];
          return aDate.compareTo(bDate);
        });
        //switch con el length de la lista
        switch (aux.length) {
          case 1:
            _historial['cantidad1'] = aux[aux.length - 1]['pedido'];
            break;
          case 2:
            _historial['cantidad1'] = aux[aux.length - 1]['pedido'];
            _historial['cantidad2'] = aux[aux.length - 2]['pedido'];
            break;
          case 3:
            _historial['cantidad1'] = aux[aux.length - 1]['pedido'];
            _historial['cantidad2'] = aux[aux.length - 2]['pedido'];
            _historial['cantidad3'] = aux[aux.length - 3]['pedido'];
            break;
        }
      }
    }
    notifyListeners();
  }

  void loadInventario(int idCliente) async {
    List _productos = await Inventarios.readProductOnly(idCliente);
    if (_productos != null) {
      for (int i = 0; i < _productos.length; i++) {
        if (i == 0) {
          if (_productos[i]['fecha'] == fechaHoy) {
            this.setInventario(i,
                id: _productos[i]['id'],
                producto: _productos[i]['producto'],
                precio: _productos[i]['precio'],
                cantidad: _productos[i]['cantidad']);
          } else {
            this.setInventario(i,
                id: _productos[i]['id'],
                producto: _productos[i]['producto'],
                precio: _productos[i]['precio']);
          }
          continue;
        }
        if (_productos[i]['fecha'] == fechaHoy) {
          this.addInventario(
            _productos[i]['id'],
            fechaHoy,
            _productos[i]['producto'],
            _productos[i]['cantidad'],
            _productos[i]['precio'],
          );
        } else {
          this.addInventario(_productos[i]['id'], fechaHoy,
              _productos[i]['producto'], 0, _productos[i]['precio']);
        }
      }
    }
  }

  void saveInventario(idCliente) async {
    List pedido = _inventario
        .where((v) => (v['pedido'] != 0 || v['cantidad'] != 0))
        .toList();
    for (int i = 0; i < pedido.length; i++) {
      // Inventarios.create(fechaPedido,cantidad,idCliente,idProducto,fechaEntrega,pedido,valor);
      await Inventarios.create(
          fechaHoy,
          pedido[i]['cantidad'],
          idCliente,
          pedido[i]['id'],
          pedido[i]['fechaEntrega'],
          pedido[i]['pedido'],
          pedido[i]['precio']);
    }
  }

  int total() {
    int total = 0;
    for (int i = 0; i < _inventario.length; i++) {
      total += _inventario[i]['pedido'] * _inventario[i]['precio'];
    }
    return total;
  }

  void reset() {
    _inventario = [];
    _historial = null;
    _inventario.add({
      'id': null,
      'fecha': fechaHoy,
      'producto': '',
      'cantidad': 0,
      'precio': 0,
      'pedido': 0,
      'fechaEntrega': filterDate(this._fechaEntrega)
    });
    _historial = {
      'producto': '',
      'cantidad1': '0',
      'cantidad2': '0',
      'cantidad3': '0',
      'precio': '',
    };
  }
}
