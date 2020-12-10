import 'package:flutter/foundation.dart';
import 'package:ventas/models/venta/pedido/pedido.dart';
import 'package:ventas/models/venta/pedido/pedidos.dart';

class PedidoProvider extends ChangeNotifier {
  List<Pedido> _pedidos = [];
  List<String> _productoPedido = [];
  Pedido _pedido;

  get pedidos => _pedidos;
  set pedidos(List<Pedido> pedidos) {
    _pedidos = pedidos;
    notifyListeners();
  }

  get productoPedido => _productoPedido;
  set productoPedido(List<String> value) {
    _productoPedido = value;
    notifyListeners();
  }

  get pedido => _pedido;
  set pedido(pedido) {
    _pedido = pedido;
    notifyListeners();
  }

  PedidoProvider() {
    nuevoPedido();
  }

  void nuevoPedido() {
    pedido = new Pedido();
  }

  Future<void> pedidoForDate(idCliente, String date) async {
    pedido.historialProducto =
        await Pedidos.readInventaryDate(idCliente, date) ?? [];
  }

  Future<void> recargarProductoPedido(int idCliente) async {
    productoPedido = await Pedidos.readProductOnly(idCliente) ?? [];
  }

  Future<void> pedidoForId(int idPedido) async {
    // inventarios = await Inventarios.readById(idInventario) ?? [];
  }

  Future<bool> pedidoCrear() async {
    bool respuesta = await Pedidos.create(pedido) ? true : false;
    /* if(respuesta)  instruccion de carga de pantalla*/
    return respuesta;
  }

  Future<bool> inventarioModificar() async {
    bool respuesta = await Pedidos.update(pedido) ? true : false;
    /* if(respuesta)  instruccion de carga de pantalla*/
    return respuesta;
  }

  Future<bool> inventarioBorrar() async {
    bool respuesta = await Pedidos.delete(pedido.id) ? true : false;
    /* if(respuesta)  instruccion de carga de pantalla*/
    return respuesta;
  }
}
