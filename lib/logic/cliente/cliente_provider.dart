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
  set clientes(List<Cliente> clients) {
    _clientes = clients;
    notifyListeners();
  }

  ClienteProvider() {
    loadCliente();
    nuevoCliente();
  }

  void nuevoCliente() {
    _cliente = new Cliente(null, '', '');
  }

  Future<void> loadCliente() async {
    clientes = await Clientes.read() ?? [];
  }

  void updateCliente(String nit, String nombre, String representante,
      String telefono, String email, String direccion, String ciudad) {
    _cliente.nit = nit;
    _cliente.nombre = nombre;
    _cliente.representante = representante;
    _cliente.telefono = telefono;
    _cliente.email = email;
    _cliente.direccion = direccion;
    _cliente.ciudad = ciudad;
    notifyListeners();
  }

  Future<void> clienteForCity(String city) async {
    clientes = await Clientes.readByCity(city) ?? [];
  }

  Future<void> clienteForName(String name) async {
    clientes = await Clientes.readByName(name) ?? [];
  }

  Future<bool> clienteCrear() async {
    bool respuesta = await Clientes.create(cliente) ? true : false;
    if (respuesta) await clienteForName(cliente.nombre);
    return respuesta;
  }

  Future<bool> clienteModificar() async {
    bool respuesta = await Clientes.update(cliente) ? true : false;
    if (respuesta) await loadCliente();
    return respuesta;
  }

  Future<bool> clienteBorrar(int id) async {
    bool respuesta = await Clientes.delete(id) ? true : false;
    if (respuesta) await loadCliente();
    return respuesta;
  }

  void resetClient() {
    this.nuevoCliente();
  }
}
