import 'package:flutter/material.dart';
import 'package:edertiz/logic/cliente/cliente_provider.dart';
import 'package:edertiz/logic/producto/producto_provider.dart';
import 'package:edertiz/logic/venta/inventario/inventario_provider.dart';
import 'package:intl/intl.dart';

ClienteProvider cliente;
ProductoProvider producto;
InventarioProvider inventario;

double widthScreen;
double heightScreen;

const Color colorGenerico = Colors.green;
enum Response { ok, cancel }
BuildContext contextoPrincipal;

var f = NumberFormat('00', 'es_CO');

String fechaHoy = filterDate(DateTime.now());

String capitalize(String s) {
  if (s == '' || s == ' ') return s;
  List<String> _s = s.split(' ');
  for (int i = 0; i < _s.length; i++) {
    _s[i] = _s[i][0].toUpperCase() + _s[i].substring(1).toLowerCase();
  }
  return _s.join(' ');
}

String filterDate(DateTime date) =>
    "${date.year}-${f.format(date.month)}-${f.format(date.day)}";

enum Ciudades {
  Todos,
  Andes,
  Betania,
  Hispania,
  Jardin,
  SantaInes,
  SantaRita,
  Taparto
}

//UNA FORMA DE COPIAR UNA BASE DE DATOS EXTERNA AL CELULAR
//static Future<void> backUp() async {
  //   String _name = Setup.DB_NAME;
  //   String dbPath = join(await getDatabasesPath(), _name);
  //   await deleteDatabase(dbPath);
  //   //COPIAR LA BASE DE DATOS DESDE EL RECURSO
  //   ByteData data = await rootBundle.load(join('data', _name));
  //   List<int> bytes =
  //       data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  //   await File(dbPath).writeAsBytes(bytes);
  // }
