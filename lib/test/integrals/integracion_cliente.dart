import 'package:edertiz/logic/cliente/cliente_provider.dart';
import 'package:edertiz/models/cliente/cliente.dart';

class IntegracionCliente {
  ClienteProvider _cliente;
  IntegracionCliente() {
    print("INICIO PRUEBAS INTEGRACION MODULO CLIENTE");

    this._cliente = new ClienteProvider();
    this._cliente.cliente = new Cliente(null, "1234", "Miguel", "La coronita",
        "avenidadX", "1234", "test@test", "BETANIA");
  }

  Future<void> start() async {
    await crearCliente();
    await modificarCliente();
    await eliminarCliente();
    print("FIN PRUEBAS INTEGRACION MODULO CLIENTE");
  }

  Future<void> crearCliente() async {
    print("INTEGRACION CREAR CLIENTE");
    bool result = await this._cliente.clienteCrear();
    if (result) {
      await this._cliente.loadCliente();
      this._cliente.cliente = this._cliente.clientes[0];
      print("TEST INTEGRACION CREAR APROBO");
    } else {
      print("TEST INTEGRACION CREAR FALLO");
    }
  }

  Future<void> modificarCliente() async {
    print("INTEGRACION MODIFICAR CLIENTE");
    bool result = await this._cliente.clienteModificar();
    print(result
        ? "TEST INTEGRACION MODIFICAR APROBO"
        : "TEST INTEGRACION MODIFICAR FALLO");
  }

  Future<void> eliminarCliente() async {
    print("INTEGRACION ELIMINAR CLIENTE");
    bool result =
        await this._cliente.clienteBorrar(this._cliente.cliente.id);
    print(result
        ? "TEST INTEGRACION ELIMINAR APROBO"
        : "TEST INTEGRACION ELIMINAR FALLO");
  }
}
