import 'package:flutter/foundation.dart';
import 'package:ventas/config/utilidades.dart';
import 'package:ventas/models/venta/inventario/inventario.dart';
import 'package:ventas/models/venta/inventario/inventarios.dart';

class InventarioProvider extends ChangeNotifier {
  List<Inventario> _inventarios = [];
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
    notifyListeners();
  }

  Future<void> inventarioHistorial(idCliente, idProducto) async {
    _inventario.historial =
        await Inventarios.readHistoryProducto(idCliente, idProducto) ?? [];
    historialUpdate(
        _inventario.historial[0].nombreProducto,
        _inventario.historial[0].cantidad,
        _inventario.historial[1].cantidad,
        _inventario.historial[2].cantidad);
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
  }
}
