import 'package:flutter/foundation.dart';
import 'package:ventas/models/cliente/cliente.dart';
import 'package:ventas/models/cliente/clientes.dart';

class ClienteProvider extends ChangeNotifier {
  List<Cliente> _clientes = [];
  Cliente _cliente = Cliente();

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
}
