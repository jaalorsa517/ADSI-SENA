import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:edertiz/models/cliente/cliente.dart';
import 'package:edertiz/models/cliente/clientes.dart';
import 'package:edertiz/models/crud.dart';

class MockCliente extends Mock implements Cliente{}
      

main() {
  Cliente cliente;
  setUp(() {
    cliente = MockCliente();
  });
  group('Modulo cliente', () {
    test('Crear Cliente', () async{
      expectLater(await Clientes.create(cliente),true);
      // expect(await Clientes.create(cliente),true | false );
    });
    test('Mostrar Cliente', () {});
    test('Actualizar Cliente', () {});
    test('Eliminar Cliente', () {});
  });
}
