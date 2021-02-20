import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ventas/config/setup.dart';

abstract class Crud {
  // ignore: missing_return
  static Future<bool> create(Object object) {}
  // ignore: missing_return
  static Future<List<Object>> read() {}
  // ignore: missing_return
  static Future<bool> update(Object object) {}
  // ignore: missing_return
  static Future<bool> delete(int idObject) {}
  // ignore: missing_return
  static Future<List<Object>> readById(Object object) {}
  static Future<Database> conectar() async {
    String _name = Setup.DB_NAME;
    try {
      String dbPath = join(await getDatabasesPath(), _name);
      return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    } catch (Exception) {
      print('EXCEPTION EN CONECTAR ${Exception.toString()}');
      return null;
    }
  }
}

void _onCreate(Database db, int version) async {
  List<String> sentences = [
    """
    CREATE TABLE IF NOT EXISTS "ciudad_cliente" (
      "idCliente"	INTEGER,
      "idCiudad"	INTEGER,
      FOREIGN KEY("idCiudad") REFERENCES "ciudad"("id"),
      FOREIGN KEY("idCliente") REFERENCES "cliente"("id")
    )""",
    """
    CREATE TABLE IF NOT EXISTS "cliente" (
    	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
    	"nit"	TEXT,
    	"nombre"	TEXT NOT NULL,
    	"representante"	TEXT,
    	"telefono"	TEXT,
    	"email"	TEXT,
    	"direccion"	TEXT
    )""",
    """
    CREATE TABLE IF NOT EXISTS "pedido" (
    	"id"	INTEGER,
    	"fecha_pedido"	TEXT NOT NULL,
    	"fecha_entrega"	TEXT NOT NULL,
    	"id_inventario"	INTEGER NOT NULL,
    	"cantidad"	INTEGER NOT NULL,
    	"valor"	INTEGER NOT NULL,
    	FOREIGN KEY("id_inventario") REFERENCES "inventario"("id"),
    	PRIMARY KEY("id")
    )""",
    """
    CREATE TABLE IF NOT EXISTS "inventario" (
    	"id"	INTEGER,
    	"cantidad"	INTEGER,
    	"fecha"	TEXT,
    	"fk_id_cliente"	INTEGER,
    	PRIMARY KEY("id")
    )""",
    """
    CREATE TABLE IF NOT EXISTS "inventario_producto" (
    	"id_Inventario"	INTEGER,
    	"id_Producto"	INTEGER,
    	PRIMARY KEY("id_Inventario","id_Producto"),
    	FOREIGN KEY("id_Inventario") REFERENCES "inventario"("id")
    )""",
    """
    CREATE TABLE IF NOT EXISTS "producto" (
    	"id"	INTEGER,
    	"nombre"	TEXT NOT NULL,
    	"precio"	INTEGER,
    	"iva"	REAL,
    	PRIMARY KEY("id")
    )""",
    """
    CREATE TABLE IF NOT EXISTS "ciudad" (
    	"id"	INTEGER,
    	"nombre"	TEXT,
    	PRIMARY KEY("id")
    )""",
    "INSERT INTO 'ciudad' VALUES (1,'ANDES')",
    "INSERT INTO 'ciudad' VALUES (2,'BETANIA')",
    "INSERT INTO 'ciudad' VALUES (3,'HISPANIA')",
    "INSERT INTO 'ciudad' VALUES (4,'JARDIN')",
    "INSERT INTO 'ciudad' VALUES (5,'SANTA INES')",
    "INSERT INTO 'ciudad' VALUES (6,'SANTA RITA')",
    "INSERT INTO 'ciudad' VALUES (7,'TAPARTO')",
  ];
  sentences.forEach((sentence) async => await db.execute(sentence));
}
