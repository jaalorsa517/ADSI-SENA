import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventas/config/utilidades.dart';
import 'package:ventas/logic/cliente/cliente_provider.dart';
import 'package:ventas/logic/venta/inventario/inventario_provider.dart';
import 'package:ventas/ui/screens/sc_datos.dart';
import 'package:ventas/ui/screens/sc_cliente.dart';
import 'package:ventas/ui/screens/sc_producto.dart';
import 'package:ventas/ui/screens/sc_venta.dart';
import 'package:ventas/ui/screens/sc_main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'logic/producto/producto_provider.dart';

void main() => runApp(Principal());

class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductoProvider>(
              create: (context) => ProductoProvider()),
          ChangeNotifierProvider<ClienteProvider>(
              create: (context) => ClienteProvider()),
          ChangeNotifierProvider<InventarioProvider>(
              create: (context) => InventarioProvider()),
        ],
        child: MaterialApp(
          theme: ThemeData(primaryColor: colorGenerico),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [const Locale('es')],
          routes: <String, WidgetBuilder>{
            '/cliente': (context) => ScCliente(),
            '/producto': (context) => ScProducto(),
            '/venta': (context) => ScVenta(context),
            '/datos': (context) => ScDatos(),
          },
          home: ScMain(),
        ));
  }
}
