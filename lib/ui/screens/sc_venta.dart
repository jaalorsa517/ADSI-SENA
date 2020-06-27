import "package:flutter/material.dart";
import "package:ventas/ui/widgets/wboton.dart";
import 'package:ventas/ui/widgets/wcalendar.dart';
import "package:ventas/ui/widgets/wcombo.dart";
import "package:ventas/logic/loaddata.dart";
import 'package:ventas/ui/widgets/wgridview.dart';

class sc_venta extends StatelessWidget {
  loadData datos;
  @override
  Widget build(BuildContext context) {
    datos = loadData(DefaultAssetBundle.of(context));
    return _build();
  }

  Widget _build() {
    return Scaffold(
      appBar: AppBar(title: Text('VENTAS'), backgroundColor: Colors.green),
      //drawer: Drawer(),
      //bottomNavigationBar: BottomNavigationBar(items: null),
      body: Text('VENTA'),
    );
  //   return Scaffold(
  //       appBar: AppBar(title: const Text('Ensayo')),
  //       drawer: Drawer(
  //           child: ListView(
  //         children: <Widget>[Ink(child: new Text('Menu'))],
  //       )),
  //       body: Column(
  //         children: <Widget>[
  //           Row(
  //             children: <Widget>[
  //               FutureBuilder<List<String>>(
  //                   future: datos.getCiudad_name(),
  //                   builder: (BuildContext context,
  //                       AsyncSnapshot<List<String>> snapshot) {
  //                     if (!snapshot.hasData) return CircularProgressIndicator();
  //                     if ((snapshot.data == null)) {
  //                       return Text('Data null');
  //                     } else {
  //                       return wcombo(
  //                         snapshot.data,
  //                         this.datos.sCliente,
  //                         key: GlobalKey(),
  //                       );
  //                     }
  //                   }),
  //               Text(datos.getDateNow())
  //             ],
  //           ),
  //           Row(
  //             children: <Widget>[
  //               StreamBuilder(
  //                   stream: datos.sCliente.stream,
  //                   builder: (BuildContext context, AsyncSnapshot snapshot) {
  //                     if (snapshot.hasError) {
  //                       print('Error');
  //                     } else if ((snapshot.data == null)) {
  //                       print('NULL');
  //                       return Text('Dato Nulo');
  //                     } else {
  //                       switch (snapshot.connectionState) {
  //                         case ConnectionState.none:
  //                           print(('Estado nada'));
  //                           return Text('Nada');
  //                         case ConnectionState.waiting:
  //                           print(('Estado esperando'));
  //                           return Text('Seleccione una ciudad');
  //                         case ConnectionState.done:
  //                           print(('Estado hecho'));
  //                           return Text('Hecho');
  //                         case ConnectionState.active:
  //                           print(('Estado activo'));
  //                           return FutureBuilder(
  //                               future: datos.getCliente_name(snapshot.data),
  //                               builder: (BuildContext context,
  //                                   AsyncSnapshot snapshot1) {
  //                                 if (!snapshot1.hasData)
  //                                   return CircularProgressIndicator();
  //                                 else
  //                                   return new Expanded(
  //                                       flex: 0,
  //                                       child: new wcombo(
  //                                           snapshot1.data, datos.sInventario,
  //                                           key: GlobalKey(
  //                                               debugLabel: 'cliente')));
  //                               });
  //                       }
  //                     }
  //                   }),
  //             ],
  //           ),
  //           Row(children: <Widget>[
  //             StreamBuilder(
  //                 stream: datos.sInventario.stream,
  //                 builder: (BuildContext context, AsyncSnapshot snapshot) {
  //                   if (!snapshot.hasData)
  //                     return CircularProgressIndicator();
  //                   else
  //                     return new FutureBuilder(builder: null);
  //                 })
  //           ]),
  //           Row(children: <Widget>[wboton()])
  //         ],
  //       ));
  }
}
