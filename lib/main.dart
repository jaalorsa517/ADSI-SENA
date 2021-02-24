import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edertiz/config/utilidades.dart';
import 'package:edertiz/logic/cliente/cliente_provider.dart';
import 'package:edertiz/logic/venta/inventario/inventario_provider.dart';
import 'package:edertiz/ui/screens/sc_datos.dart';
import 'package:edertiz/ui/screens/sc_cliente.dart';
import 'package:edertiz/ui/screens/sc_producto.dart';
import 'package:edertiz/ui/screens/sc_venta.dart';
import 'package:edertiz/ui/screens/sc_main.dart';
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
          title: "EDERTIZ",
          theme: ThemeData(primaryColor: colorGenerico),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [const Locale('es', 'CO')],
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
