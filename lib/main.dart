import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventas/logic/cliente/cliente_provider.dart';
import 'package:ventas/ui/screens/sc_cliente.dart';
import 'package:ventas/ui/screens/sc_producto.dart';
import 'package:ventas/ui/screens/sc_venta.dart';
import 'package:ventas/ui/screens/sc_main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ventas/ui/variables.dart';

void main() => runApp(Principal());

class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ClienteProvider>(create: (context) => cliente)
        ],
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [const Locale('es')],
          routes: <String, WidgetBuilder>{
            '/cliente': (context) => sc_cliente(),
            '/producto': (context) => sc_producto(),
            '/venta': (context) => sc_venta(),
          },
          home: sc_main(),
        ));
  }
}
