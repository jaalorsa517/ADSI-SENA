import 'package:edertiz/models/cliente/clientes.dart';
import 'package:edertiz/models/cliente/cliente.dart';

class Cliente_test {
  Cliente_test() {
    print("TESTING ON MODULE CLIENTE");
  }

  Future<void> start() async {
    await crea();
    await muestra();
    await actualiza();
    await elimina();
    print("FINISHED TESTING ON MODULE CLIENTE");
  }

  void crea() async {
    print("TESTING CREATE");
    bool result = await Clientes.create(Cliente(null, "123", "Jaime", "test",
        "avenidadX", "1234", "test@test", "ANDES"));
    print(result ? "TEST APROBADO" : "TEST NO APROBADO");
  }

  void muestra() async {
    print("TESTING READ");
    List result = await Clientes.read();
    print(result != null ? "TEST APROBADO" : "TEST NO APROBADO");
  }

  void actualiza() async {
    print("TESTING UPDATE");
    bool result = await Clientes.update(Cliente(
        await Clientes.getId(),
        "1234567",
        "Jaime",
        "Jaime admin",
        "AvenidaY",
        "12345",
        "test2@test",
        "ANDES"));
    print(result ? "TEST APROBADO" : "TEST NO APROBADO");
  }

  void elimina() async {
    print("TESTING DELETE");
    bool result = await Clientes.delete(await Clientes.getId());
    print(result ? "TEST APROBADO" : "TEST NO APROBADO");
  }
}
