import 'package:flutter/foundation.dart';
import 'package:ventas/models/cliente/cliente.dart';
import 'package:ventas/models/cliente/clientes.dart';

class ClienteProvider extends ChangeNotifier {
  List<Cliente> _clientes = [];
  Cliente _cliente;

  get cliente => _cliente;
  set cliente(client) {
    _cliente = client;
    notifyListeners();
  }

  get clientes => _clientes;
  set clientes(client) {
    _clientes = client;
    notifyListeners();
  }

  ClienteProvider() {
    loadCliente();
    _cliente = Cliente();
  }

  Future<void> loadCliente() async {
    _clientes = await Clientes.read();
    notifyListeners();
  }

  Future<void> clienteForCity(String city) async {
    _clientes = await Clientes.readByCity(city);
    notifyListeners();
  }

  Future<void> clienteForName(String name) async {
    _clientes = await Clientes.readByName(name);
    notifyListeners();
  }

  Future<bool> clienteCrear() async {
    return await Clientes.create(_cliente) ? true : false;
  }

  Future<bool> clienteModificar() async {
    return await Clientes.update(_cliente) ? true : false;
  }

  Future<bool> clienteBorrar(int id) async {
    return await Clientes.delete(id) ? true : false;
  }
}
