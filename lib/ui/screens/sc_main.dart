import 'package:flutter/material.dart';
import 'package:ventas/logic/cliente/cliente_provider.dart';
import 'package:ventas/ui/variables.dart';
import 'package:ventas/ui/widgets/wboton.dart';

class sc_main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cliente = ClienteProvider();
    return Scaffold(
        appBar: AppBar(title: Text('INICIO'), backgroundColor: Colors.green),
        body: Center(
            child: Column(children: <Widget>[
          new wboton('CLIENTES', '/cliente'),
          new wboton('PRODUCTOS', '/producto'),
          new wboton('VENTA', '/venta')
        ])));
  }
}
