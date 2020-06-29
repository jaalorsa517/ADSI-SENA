import 'package:test/test.dart';
import 'package:ventas/models/cliente/cliente.dart';
import 'package:ventas/models/cliente/clientes.dart';

void main() {
  test('Debe retornar True', () async {
    expect(await Clientes.create(Cliente('123', 'Jaime')), true);
  });
}
