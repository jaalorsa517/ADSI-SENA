import 'package:flutter/material.dart';
import 'package:ventas/logic/cliente/cliente_provider.dart';
import 'package:ventas/logic/producto/producto_provider.dart';
import 'package:ventas/logic/venta/inventario/inventario_provider.dart';
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
