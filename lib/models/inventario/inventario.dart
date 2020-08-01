class Inventario {
  int _id;
  String _fecha;
  int _idProducto;
  String _producto;
  int _cantidad;
  int _idCliente;
  String _cliente;

  Inventario(
      [this._id,
      this._fecha,
      this._idProducto,
      this._producto,
      this._cantidad,
      this._idCliente,
      this._cliente]);

  // ignore: unnecessary_getters_setters
  int get idProducto => _idProducto;

  set idProducto(int value) => _idProducto = value;

  // ignore: unnecessary_getters_setters
  int get id => _id;

  // ignore: unnecessary_getters_setters
  set id(int value) => _id = value;

  // ignore: unnecessary_getters_setters
  int get cantidad => _cantidad;

  // ignore: unnecessary_getters_setters
  set cantidad(int value) => _cantidad = value;

  // ignore: unnecessary_getters_setters
  String get fecha => _fecha;

  // ignore: unnecessary_getters_setters
  set fecha(String value) => _fecha = value;

  // ignore: unnecessary_getters_setters
  int get idCliente => _idCliente;

  // ignore: unnecessary_getters_setters
  set idCliente(int value) => _idCliente = value;

  // ignore: unnecessary_getters_setters
  String get cliente => _cliente;

  // ignore: unnecessary_getters_setters
  set cliente(String value) => _cliente = value;

  // ignore: unnecessary_getters_setters
  String get producto => _producto;

  // ignore: unnecessary_getters_setters
  set producto(String value) => _producto = value;
}
