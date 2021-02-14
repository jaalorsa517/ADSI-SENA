import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventas/logic/cliente/cliente_provider.dart';
import 'package:ventas/config/utilidades.dart';
import 'package:ventas/logic/producto/producto_provider.dart';
import 'package:ventas/logic/venta/inventario/inventario_provider.dart';
import 'package:ventas/ui/widgets/wboton.dart';

class ScMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    heightScreen = MediaQuery.of(context).size.height;

    producto = Provider.of<ProductoProvider>(context);
    cliente = Provider.of<ClienteProvider>(context);
    inventario = Provider.of<InventarioProvider>(context);

    contextoPrincipal = context;

    return Scaffold(
        appBar: AppBar(
            title: Center(child: Text('INICIO')),
            backgroundColor: Colors.green),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new WBoton('CLIENTES', '/cliente'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new WBoton('PRODUCTOS', '/producto'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new WBoton('VENTA', '/venta'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new WBoton('BACKUP', '/datos'),
                )
              ])),
        ));
  }
}
