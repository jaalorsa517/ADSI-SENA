import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventas/logic/cliente/cliente_provider.dart';
import 'package:ventas/config/utilidades.dart';
import 'package:ventas/logic/producto/producto_provider.dart';
import 'package:ventas/ui/widgets/wboton.dart';

class ScMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    heightScreen = MediaQuery.of(context).size.height;
    producto = Provider.of<ProductoProvider>(context);
    cliente = Provider.of<ClienteProvider>(context);
    contextoPrincipal = context;
    return Scaffold(
        appBar: AppBar(title: Text('INICIO'), backgroundColor: Colors.green),
        body: Center(
            child: Column(children: <Widget>[
          new WBoton('CLIENTES', '/cliente'),
          new WBoton('PRODUCTOS', '/producto'),
          new WBoton('VENTA', '/venta'),
          new WBoton('BACKUP', '/backup')
        ])));
  }
}
