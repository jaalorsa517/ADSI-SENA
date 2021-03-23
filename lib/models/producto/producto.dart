class Producto {
  int _id;
  String _nombre;
  int _precio;
  double _iva;

  Producto([this._id, this._nombre, this._precio, this._iva]);

  // ignore: unnecessary_getters_setters
  int get id => _id;

  // ignore: unnecessary_getters_setters
  set id(int value) => _id = value;

  // ignore: unnecessary_getters_setters
  String get nombre => _nombre;

  // ignore: unnecessary_getters_setters
  set nombre(String value) => _nombre = value;

  // ignore: unnecessary_getters_setters
  int get precio => _precio;

  // ignore: unnecessary_getters_setters
  set precio(int value) => _precio = value;

  // ignore: unnecessary_getters_setters
  double get iva => _iva;

  // ignore: unnecessary_getters_setters
  set iva(double value) => _iva = value;
}
