class Pedido {
  int _id;
  String _fechaPedido;
  String _fechaEntrega;
  int _idInventario;
  int _cantidad;
  int _valor;

  Pedido(
      [this._id,
      this._fechaPedido,
      this._fechaEntrega,
      this._idInventario,
      this._cantidad,
      this._valor]);

  // ignore: unnecessary_getters_setters
  int get id => _id;

  // ignore: unnecessary_getters_setters
  set id(int value) => _id = value;

  // ignore: unnecessary_getters_setters
  String get fechaPedido => _fechaPedido;

  // ignore: unnecessary_getters_setters
  set fechaPedido(String value) => _fechaPedido = value;

  // ignore: unnecessary_getters_setters
  String get fechaEntrega => _fechaEntrega;

  // ignore: unnecessary_getters_setters
  set fechaEntrega(String value) => _fechaEntrega = value;

  // ignore: unnecessary_getters_setters
  int get idInventario => _idInventario;

  // ignore: unnecessary_getters_setters
  set idInventario(int value) => _idInventario = value;

  // ignore: unnecessary_getters_setters
  int get cantidad => _cantidad;

  // ignore: unnecessary_getters_setters
  set cantidad(int value) => _cantidad = value;

  // ignore: unnecessary_getters_setters
  int get valor => _valor;

  // ignore: unnecessary_getters_setters
  set valor(int value) => _valor = value;
}
