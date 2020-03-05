import "package:flutter/material.dart";
import "package:ventas/ui/widgets/wboton.dart";
import 'package:ventas/ui/widgets/wcalendar.dart';
import "package:ventas/ui/widgets/wcombo.dart";

import 'package:ventas/models/producto.dart';
import 'package:ventas/ui/widgets/wgridview.dart';

class sc_venta extends StatelessWidget {

  @override
  Widget build(BuildContext context) => _build(context);

  Future<List<String>> getData() async {
    List <String> list=[];
    Producto p = Producto();
    var result = await p.conectar('pedidoDB.db');
    print(p.mensaje);
    if (result) {
      List<Producto> productos = await p.select();
      //productos.forEach((e) => list.add(e.nombre));
      for (int i = 0; i < productos.length ; i++) {
        list.add(productos[i].nombre);
      }
      return list;
    }
    return ['NO DATA'];
  }

  Widget _build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(title: const Text('Ensayo')),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[wcombo(Ciudad) ,Text('FECHA')],
            ),
            Row(
              children: <Widget>[wcombo(Cliente),wcalendar('ENTREGA')],
            ),
            Row(children: <Widget>[wgridview]),
            // Row(children: <Widget>[
            //   FutureBuilder<List<String>>(
            //       future: getData(),
            //       builder: (BuildContext context,
            //           AsyncSnapshot<List<String>> snapshot) {
            //         if (!snapshot.hasData) return CircularProgressIndicator();
            //         return wcombo(snapshot.data);
            //       })
            // ]),
            Row(children: <Widget>[wboton(GUARDAR)])
          ],
        ));
  }
}
