import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ventas/config/utilidades.dart';
import 'package:ventas/logic/venta/inventario/inventario_provider.dart';
import 'package:ventas/logic/venta/pedido/pedido_provider.dart';
import 'package:ventas/logic/producto/producto_provider.dart';

class ScVenta extends StatefulWidget {
  final BuildContext _context;

  ScVenta(this._context);
  @override
  State<StatefulWidget> createState() {
    return _ScVenta(_context);
  }
}

class _ScVenta extends State<ScVenta> {
  List<String> titulo = ['Resumen', 'Inventario', 'Ventas'];
  int _vista = 0;
  List<Widget> _pantalla = [];
  _ScVenta(context) {
    _pantalla = [_resumen(context), _inventario(context), _venta(context)];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: <Widget>[
          Flexible(
            child: Text(titulo[_vista]),
            fit: FlexFit.tight,
          ),
          Flexible(
            child: Text(fechaHoy),
          ),
        ]),
        backgroundColor: colorGenerico,
      ),
      body: _pantalla[_vista],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: colorGenerico,
          selectedItemColor: Colors.amber[100],
          unselectedItemColor: Colors.white,
          currentIndex: _vista,
          onTap: (i) async {
            setState(() {
              _vista = i;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                label: titulo[0],
                icon: Icon(
                  Icons.shopping_cart,
                )),
            BottomNavigationBarItem(
                label: titulo[1],
                icon: Icon(
                  Icons.account_balance_wallet,
                )),
            BottomNavigationBarItem(
                label: titulo[2],
                icon: Icon(
                  Icons.add_shopping_cart,
                )),
          ]),
    );
  }

  Widget _venta(BuildContext context) {
    List<TextEditingController> columnPedido = List.generate(
        inventario.getInventario().length, (i) => TextEditingController());
    return Padding(
        padding: EdgeInsets.all(0),
        child: Column(children: <Widget>[
          Flexible(
              flex: 7,
              fit: FlexFit.tight,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: <DataColumn>[
                          DataColumn(label: Text('PRODUCTO')),
                          DataColumn(label: Text('INVENTARIO')),
                          DataColumn(label: Text('PEDIDO')),
                        ],
                        rows: List.generate(
                            pedido.pedido.historialProducto.length,
                            (index) => DataRow(cells: <DataCell>[
                                  DataCell(Text(inventario
                                      .getInventario()[index]['nombre'])),
                                  DataCell(Text(inventario
                                      .getInventario()[index]['cantidad'])),
                                  DataCell(TextField(
                                    controller: columnPedido[index],
                                    autofocus: false,
                                    keyboardType: TextInputType.number,
                                  ))
                                ])),
                      ))))
        ]));
  }

  Widget _inventario(BuildContext context) {
    return Consumer<InventarioProvider>(builder: (context, parent, child) {
      List<TextEditingController> columnInventario = List.generate(
          inventario.getInventario().length,
          (i) => TextEditingController(
              text: inventario.getInventario()[i]['cantidad'].toString()));
      return Padding(
          padding: EdgeInsets.all(0),
          child: Column(children: <Widget>[
            Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: ListTile(
                    trailing: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.pushNamed(context, "/producto");
                        }),
                    title: Text(inventario.getHistorial()['producto']),
                    isThreeLine: true,
                    subtitle: Column(children: <Widget>[
                      Text('Últimos pedidos'),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                            child: Text(inventario
                                .getHistorial()['cantidad1']
                                .toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: Text(inventario
                                .getHistorial()['cantidad2']
                                .toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                            child: Text(inventario
                                .getHistorial()['cantidad3']
                                .toString()),
                          )
                        ],
                      )
                    ]))),
            Flexible(
                flex: 7,
                fit: FlexFit.tight,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          horizontalMargin: 0,
                          columnSpacing: 0,
                          dataRowHeight: heightScreen / 9,
                          columns: <DataColumn>[
                            DataColumn(label: Text('PRODUCTO')),
                            DataColumn(
                              label: Text('INVENTARIO'),
                              numeric: true,
                            ),
                          ],
                          rows: List.generate(
                              inventario.getInventario().length,
                              (index) => DataRow(cells: <DataCell>[
                                    DataCell(InkWell(
                                        child: Container(
                                      width: widthScreen * 2 / 3,
                                      child: Text(inventario
                                          .getInventario()[index]['producto']),
                                    ))),
                                    DataCell(
                                        TextField(
                                          textAlign: TextAlign.right,
                                          onTap: () async {
                                            columnInventario[index].selection =
                                                TextSelection(
                                                    baseOffset: 0,
                                                    extentOffset:
                                                        columnInventario[index]
                                                            .text
                                                            .length);
                                          },
                                          // onEditingComplete: () async {
                                          //   FocusScope.of(context)
                                          //       .requestFocus(new FocusNode());
                                          // },
                                          controller: columnInventario[index],
                                          autofocus: false,
                                          keyboardType: TextInputType.number,
                                        ),
                                        placeholder: true)
                                  ])),
                        ))))
          ]));
    });
  }

  Widget _resumen(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListTile(
              title: Text('cliente'),
              trailing: Text('fecha pedido'),
              leading: Text('fecha entrega'),
            )),
            Flexible(
                child: DataTable(
              columns: <DataColumn>[
                DataColumn(label: Text('')),
                DataColumn(label: Text(''))
              ],
              rows: <DataRow>[
                DataRow(
                    cells: <DataCell>[DataCell(Text('')), DataCell(Text(''))])
              ],
            )),
            Flexible(
                child: Row(children: <Widget>[
              Flexible(child: Text('')),
              Flexible(child: Text('')),
            ])),
          ],
        ));
  }
}
