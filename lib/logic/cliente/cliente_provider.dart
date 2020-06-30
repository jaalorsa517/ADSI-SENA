import 'package:flutter/foundation.dart';
import 'package:ventas/models/cliente/cliente.dart';
import 'package:ventas/models/cliente/clientes.dart';

class ClienteProvider with ChangeNotifier {
  List<Cliente> _clientes = [];
  get clientes => _clientes;
  set(client) {
    _clientes = client;
    notifyListeners();
  }

  ClienteProvider() {
    Clientes.read().then((value) {
      _clientes = value;
      notifyListeners();
    });

    print('Constructor ${this._clientes}');
  }
}
