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
  static const List<String> COLUMN_CIUDAD = ['ciudad.id', 'ciudad.nombre'];

  static const String CIUDAD_CLIENTE_TABLE = 'ciudad_cliente';
  static const List<String> COLUMN_CIUDAD_CLIENTE = [
    'ciudad_cliente.idCliente',
    'ciudad_cliente.idCiudad'
  ];
}
