import 'package:flutter/material.dart';
import 'package:ventas/logic/cliente/cliente_provider.dart';
import 'package:ventas/logic/producto/producto_provider.dart';

ClienteProvider cliente;
ProductoProvider producto;
double widthScreen;
double heightScreen;
const Color colorGenerico = Colors.green;
enum Response { ok, cancel }
BuildContext contextoPrincipal;

String capitalize(String s) {
  if (s == '' || s == ' ') return s;
  List<String> _s = s.split(' ');
  for (int i = 0; i < _s.length; i++) {
    _s[i] = _s[i][0].toUpperCase() + _s[i].substring(1).toLowerCase();
  }
  return _s.join(' ');
}