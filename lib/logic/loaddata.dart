import 'dart:async';

import 'package:flutter/services.dart';
import "package:ventas/models/producto.dart";
import "package:ventas/models/ciudad.dart";
import "package:ventas/models/cliente.dart";
import "package:ventas/models/inventario.dart";

class loadData {
  final String DB = 'pedidoDB.db';
  AssetBundle asset;
  StreamController sCiudad = new StreamController.broadcast();
  StreamController sCliente = new StreamController.broadcast();
  StreamController sInventario = new StreamController();

  loadData(this.asset) {}

  @override
  void dispose() {
    sCiudad.close();
    sCliente.close();
  }

  String getDateNow() {
    return '${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}';
  }

  Future<List<String>> getProductos_name() async {
    return _getLista(Producto());
  }

  Future<List<String>> getInventario() {
    return _getLista(Inventario());
  }

  Future<List<String>> getCiudad_name() async {
    return _getLista(Ciudad());
  }

  Future<List<String>> getCliente_name(String ciudad) async {
    List<String> list = [];
    Cliente c = Cliente();
    var result = await c.conectar(DB, this.asset);
    print(c.mensaje);
    if (result) {
      List<Cliente> cliente = await c.selectForCiudad(ciudad);
      c.desconectar();
      cliente.forEach((d) => list.add(d.nombre));
      return list;
    }
    return null;
  }

  Future<List<String>> _getLista(var o, {String where}) async {
    List<String> list = [];
    var result = await o.conectar(DB, this.asset);
    if (result) {
      List<Ciudad> ciudad = await o.select();
      o.desconectar();
      ciudad.forEach((d) => list.add(d.nombre));
      return list;
    }
    return null;
  }
}
