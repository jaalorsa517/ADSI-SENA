class Setup {
  static const String DB_NAME = 'pedidoDB_Test.db';

  static const String CLIENTE_TABLE = 'cliente';
  static const Map<String, String> COLUMN_CLIENTE = {
    'id': 'id',
    'nit': 'nit',
    'nombre': 'nombre',
    'admin': 'representante',
    'telefono': 'telefono',
    'email': 'email',
    'direccion': 'direccion',
  };

  static const String CIUDAD_TABLE = 'ciudad';
  static const Map<String, String> COLUMN_CIUDAD = {
    'id': 'id',
    'nombre': 'nombre'
  };

  static const String CIUDAD_CLIENTE_TABLE = 'ciudad_cliente';
  static const Map<String, String> COLUMN_CIUDAD_CLIENTE = {
    'idCliente': 'idCliente',
    'idCiudad': 'idCiudad'
  };

  static const String PRODUCTO_TABLE = 'producto';
  static const Map<String, String> COLUMN_PRODUCTO = {
    'id': 'id',
    'nombre': 'nombre',
    'precio': 'precio',
    'iva': 'iva'
  };

  static const String INVENTARIO_TABLE = 'inventario';
  static const Map<String, String> COLUMN_INVENTARIO = {
    'id': 'id',
    'cantidad': 'cantidad',
    'fecha': 'fecha',
    'idCliente': 'fk_id_cliente',
  };

  static const String INVENTARIO_PRODUCTO_TABLE = 'inventario_producto';
  static const Map<String, String> COLUMN_INVENTARIO_PRODUCTO = {
    'idInventario': 'id_Inventario',
    'idProducto': 'id_Producto',
  };

  static const String PEDIDO_TABLE = 'pedido';
  static const Map<String, String> COLUMN_PEDIDO = {
    'id': 'id',
    'fechaPedido': 'fecha_pedido',
    'fechaEntrega': 'fecha_entrega',
    'idInventario': 'id_inventario',
    'cantidad': 'cantidad',
    'valor': 'valor'
  };
}
