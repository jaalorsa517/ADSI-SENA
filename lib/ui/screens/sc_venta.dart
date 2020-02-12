import "package:flutter/material.dart";
import 'package:ventas/ui/screens/sc_producto.dart';
import "package:ventas/ui/widgets/wboton.dart";
import 'package:ventas/ui/widgets/wcalendar.dart';
import "package:ventas/ui/widgets/wcombo.dart";

class sc_venta extends StatelessWidget {
  List <String> list=['UNO','DOS','TRES'];

  @override
  Widget build(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return MaterialApp(
        routes: <String, WidgetBuilder>{
          '/producto': (BuildContext context) => sc_producto()
        },
        home: Scaffold(
            appBar: AppBar(title: const Text('Ensayo')),
            body: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[wcalendar('Pedido'),wcalendar('Entrega')],
                ),
                Row(
                  children: <Widget>[Text("Producto"), Text("Stock")],
                ),
                Row(children: <Widget>[wcombo(this.list)]),
                Row(children: <Widget>[wboton()])
              ],
            )));
  }
}
