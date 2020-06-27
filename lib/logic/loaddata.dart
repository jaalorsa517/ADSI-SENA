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
  Clientes _clientes;
  Ciudades _ciudades;
  List <String> ciudades;

  loadData(this.asset) {
    _clientes = new Clientes();
    _ciudades = new Ciudades();
  }

  Future<List> getCliente() async {
    if (_clientes.db == null) {
      await _clientes.conectar(this.DB, this.asset);
    }
    return _clientes.select();
  }

  Future <List> getCiudades()async{
    if(_ciudades.db==null){
    await _ciudades.conectar(this.DB, this.asset);
    }
    return _ciudades.select();
    
  }

  @override
  void dispose() {
    sCiudad.close();
    sCliente.close();
  }

  static String getDateNow() {
    return '${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}';
  }
}
