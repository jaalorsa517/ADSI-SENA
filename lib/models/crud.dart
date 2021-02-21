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
    CREATE TABLE IF NOT EXISTS "ciudad" (
    	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
    	"nombre"	TEXT
    )""",
    """
    CREATE TABLE IF NOT EXISTS "ciudad_cliente" (
      "idCliente"	INTEGER,
      "idCiudad"	INTEGER,
      FOREIGN KEY("idCiudad") REFERENCES "ciudad"("id"),
      FOREIGN KEY("idCliente") REFERENCES "cliente"("id")
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
    CREATE TABLE IF NOT EXISTS "inventario" (
    	"id" INTEGER PRIMARY KEY AUTOINCREMENT,
    	"cantidad"	INTEGER,
    	"fecha"	TEXT,
    	"fk_id_cliente"	INTEGER
    )""",
    """
    CREATE TABLE IF NOT EXISTS "pedido" (
    	"id" INTEGER PRIMARY KEY AUTOINCREMENT,
    	"fecha_pedido"	TEXT NOT NULL,
    	"fecha_entrega"	TEXT NOT NULL,
    	"id_inventario"	INTEGER NOT NULL,
    	"cantidad"	INTEGER NOT NULL,
    	"valor"	INTEGER NOT NULL,
    	FOREIGN KEY("id_inventario") REFERENCES "inventario"("id")
    )""",
    """
    CREATE TABLE IF NOT EXISTS "inventario_producto" (
    	"id_Inventario"	INTEGER,
    	"id_Producto"	INTEGER,
    	PRIMARY KEY("id_Inventario","id_Producto"),
    	FOREIGN KEY("id_Inventario") REFERENCES "inventario"("id")
    )""",
    "INSERT INTO 'ciudad' VALUES (1,'ANDES')",
    "INSERT INTO 'ciudad' VALUES (2,'BETANIA')",
    "INSERT INTO 'ciudad' VALUES (3,'HISPANIA')",
    "INSERT INTO 'ciudad' VALUES (4,'JARDIN')",
    "INSERT INTO 'ciudad' VALUES (5,'SANTA INES')",
    "INSERT INTO 'ciudad' VALUES (6,'SANTA RITA')",
    "INSERT INTO 'ciudad' VALUES (7,'TAPARTO')",
    "INSERT INTO 'cliente' VALUES (454,'','Supermercado Tesoro','Supermercado Tesoro','','','');",
    "INSERT INTO 'ciudad_cliente' VALUES (454,1)",
    // "INSERT INTO 'producto' VALUES (1001,'AGUA MONTEFRIO BTLLA X 600',1050,0)",
    // "INSERT INTO 'producto' VALUES (1002,'ALBONDIGON X 250',2750,0.19)",
    "INSERT INTO 'producto' VALUES (1003,'ALBONDIGON X 500',5200,0.19)",
    "INSERT INTO 'producto' VALUES (1004,'AREQUIPE A GRANEL CAJA X 5KG',43700,0.19)",
    "INSERT INTO 'producto' VALUES (1005,'AREQUIPE ALTA DENSI GRANEL * 10 K FINO',90700,0.19)",
    // "INSERT INTO 'producto' VALUES (1006,'AREQUIPE COLANTA BOLSA X 1000',8700,0.19)",
    // "INSERT INTO 'producto' VALUES (1007,'LECHE EN POLVO INFANTIL*400 GRS',7990,0)",
    // "INSERT INTO 'producto' VALUES (1008,'AREQUIPE COLANTA X 500',6400,0.19)",
    // "INSERT INTO 'producto' VALUES (1009,'AREQUIPE COLANTA*50 GRS',850,0.19)",
    // "INSERT INTO 'producto' VALUES (1010,'AREQUIPE COLANTA*50 GRS*30 UND + BOMBONERA',17800,0.16)",
    "INSERT INTO inventario VALUES(1,2,'2021-02-20',454)",
    "INSERT INTO inventario_producto VALUES(1,1003)",
    "INSERT INTO pedido VALUES (1,'2021-02-20','2021-02-20',1,5,6000)",
    "INSERT INTO inventario VALUES(2,5,'2021-02-20',454)",
    "INSERT INTO inventario_producto VALUES(2,1004)",
    "INSERT INTO pedido VALUES (2,'2021-02-20','2021-02-20',2,2,8000)",
    "INSERT INTO inventario VALUES(3,10,'2021-02-20',454)",
    "INSERT INTO inventario_producto VALUES(3,1004)",
    "INSERT INTO pedido VALUES (3,'2021-02-18','2021-02-20',3,10,4000)",
    "INSERT INTO inventario VALUES(4,7,'2021-02-20',454)",
    "INSERT INTO inventario_producto VALUES(4,1004)",
    "INSERT INTO pedido VALUES (4,'2021-02-10','2021-02-20',4,3,3000)",
    "INSERT INTO inventario VALUES(5,1,'2021-02-20',454)",
    "INSERT INTO inventario_producto VALUES(5,1005)",
    "INSERT INTO pedido VALUES (5,'2021-02-20','2021-02-20',5,1,2000)"
  ];
  sentences.forEach((sentence) async => await db.execute(sentence));
}
