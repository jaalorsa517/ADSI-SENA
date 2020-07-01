class Setup {
  static const String DB_NAME = 'pedidoDB.db';

  static const String CLIENT_TABLE = 'cliente';
  static const List<String> COLUMN_CLIENTE = [
    'cliente.id', //0
    'cliente.nit', //1
    'cliente.nombre', //2
    'cliente.representante', //3
    'cliente.telefono', //4
    'cliente.email', //5
    'cliente.direccion', //6
  ];

  static const String CIUDAD_TABLE = 'ciudad';
  static const List<String> COLUMN_CIUDAD = [
    'ciudad.id', //0
    'ciudad.nombre' //1
  ];

  static const String CIUDAD_CLIENTE_TABLE = 'ciudad_cliente';
  static const List<String> COLUMN_CIUDAD_CLIENTE = [
    'ciudad_cliente.idCliente', //0
    'ciudad_cliente.idCiudad' //1
  ];

  static const String PRODUCTO_TABLE = 'producto';
  static const List<String> COLUMN_PRODUCTO = [
    'producto.id', //0
    'producto.nombre', //1
    'producto.precio', //2
    'producto.iva' //3
  ];
}
