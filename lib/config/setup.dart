class Setup {
  static const String DB_NAME = 'pedidoDB.db';

  static const String CLIENT_TABLE = 'cliente';
  static const List<String> COLUMN_CLIENTE = [
    'id', //0
    'nit', //1
    'nombre', //2
    'representante', //3
    'telefono', //4
    'email', //5
    'direccion', //6
  ];

  static const String CIUDAD_TABLE = 'ciudad';
  static const List<String> COLUMN_CIUDAD = [
    'id', //0
    'nombre' //1
  ];

  static const String CIUDAD_CLIENTE_TABLE = 'ciudad_cliente';
  static const List<String> COLUMN_CIUDAD_CLIENTE = [
    'idCliente', //0
    'idCiudad' //1
  ];

  static const String PRODUCTO_TABLE = 'producto';
  static const List<String> COLUMN_PRODUCTO = [
    'id', //0
    'nombre', //1
    'precio', //2
    'iva' //3
  ];
}
