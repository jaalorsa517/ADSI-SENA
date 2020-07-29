import 'package:ventas/config/utilidades.dart';
import 'package:test/test.dart';

main() {
  group('Funcion capitalize', () {
    test('Funcion capitalize en mayuscula', () {
      expect(capitalize('HOLA MUNDO'), 'Hola Mundo');
    });
    test('Funcion capitalize en minusculas', () {
      expect(capitalize('hola mundo'), 'Hola Mundo');
    });
    test('Funcion capitalize en cadena vacia', () {
      expect(capitalize(''), '');
    });
    test('Funcion capitalize con espacio', () {
      expect(capitalize(' '), ' ');
    });
  });
}
