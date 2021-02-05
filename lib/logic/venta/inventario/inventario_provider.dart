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
    notifyListeners();
  }

  void setInventario(int index, String fecha, String producto, int cantidad) {
    _inventario[index]['fecha'] = fecha;
    _inventario[index]['producto'] = producto;
    _inventario[index]['cantidad'] = cantidad;
    notifyListeners();
  }

  void deleteInventario(int index) {
    _inventario.removeAt(index);
    notifyListeners();
  }

  /**** Propiedades del historial ****/
  Map getHistorial() => _historial;

  void setHistorial(
      String producto, int cantidad1, int cantidad2, int cantidad3) {
    _historial['producto'] = producto;
    _historial['cantidad1'] = cantidad1;
    _historial['cantidad2'] = cantidad2;
    _historial['cantidad3'] = cantidad3;
    notifyListeners();
  }

  /* List<Inventario> _inventarios = [];
  Inventario _inventario;
  List<String> _productosInventario = []; //Solo un puente
  List<Map<String, dynamic>> inventarioHoy =
      []; //Cargar solo los productos e inicializa cantidades
  Map<String, dynamic> historial = {}; //para mostrar en la card

  get inventarios => _inventarios;
  set inventarios(List<Inventario> invents) {
    _inventarios = invents;
    notifyListeners();
  }

  get inventario => _inventario;
  set inventario(invent) {
    _inventario = invent;
    notifyListeners();
  }

  InventarioProvider() {
    nuevoInventario();
  }

  void nuevoInventario() {
    inventario = new Inventario();
  }

  void historialUpdate(String product, [int c1, int c2, int c3]) {
    historial['producto'] = product;
    historial['cantidad1'] = c1.toString() ?? 0.toString();
    historial['cantidad2'] = c2.toString() ?? 0.toString();
    historial['cantidad3'] = c3.toString() ?? 0.toString();
    // notifyListeners();
  }

  Future<void> inventarioHistorial(idCliente, idProducto) async {
    _inventario.historial =
        await Inventarios.readHistoryProducto(idCliente, idProducto) ?? [];
    if (_inventario.historial.length > 0) {
      historialUpdate(
          // Esta logica esta mala
          _inventario.historial[0].nombreProducto,
          _inventario.historial[0].cantidad ?? 0,
          _inventario.historial[1].cantidad ?? 0,
          _inventario.historial[2].cantidad ?? 0);
    }
  }

  Future<void> inventarioProductoOnly(idCliente) async {
    inventario.fecha = fechaHoy;
    inventario.idCliente = idCliente;
    _productosInventario = await Inventarios.readProductOnly(idCliente) ?? [];
    inventarioHoy = List.generate(_productosInventario.length,
        (i) => {'producto': _productosInventario[i], 'cantidad': 0});
  }

  Future<void> inventarioForId(int idInventario) async {
    // inventarios = await Inventarios.readById(idInventario) ?? [];
  }

  Future<bool> inventarioCrear(int cantidad) async {
    inventario.cantidad = cantidad;
    bool respuesta = await Inventarios.create(inventario) ? true : false;
    if (respuesta) {
      inventarioHoy;
      historial;
    }
    return respuesta;
  }

  Future<bool> inventarioModificar() async {
    bool respuesta = await Inventarios.update(inventario) ? true : false;
    /* if(respuesta)  instruccion de carga de pantalla*/
    return respuesta;
  }

  Future<bool> inventarioBorrar() async {
    bool respuesta = await Inventarios.delete(inventario.id) ? true : false;
    /* if(respuesta)  instruccion de carga de pantalla*/
    return respuesta;
  } */
}
