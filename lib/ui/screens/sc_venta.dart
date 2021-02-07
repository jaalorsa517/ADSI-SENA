import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ventas/config/utilidades.dart';
import 'package:ventas/logic/venta/inventario/inventario_provider.dart';
import 'package:intl/intl.dart';

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
  var filter = new NumberFormat();

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
    return Consumer<InventarioProvider>(builder: (context, parent, child) {
      List<TextEditingController> columnPedido = List.generate(
          inventario.getInventario().length,
          (i) => TextEditingController(
              text: inventario.getInventario()[i]['pedido'].toString()));
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
                  leading: IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        inventario.deleteInventario(
                            inventario.findIndexInventario(
                                inventario.getHistorial()['producto']));
                        inventario.setHistorial(producto: "", precio: '');
                      }),
                  title: Text(
                    inventario.getHistorial()['producto'],
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Center(
                      child: Text("\$${inventario.getHistorial()['precio']}")),
                )),
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
                              inventario.getInventario().length,
                              (index) => DataRow(cells: <DataCell>[
                                    DataCell(
                                        InkWell(
                                            child: Container(
                                          width: widthScreen * 1 / 4,
                                          child: Text(
                                              inventario.getInventario()[index]
                                                  ['producto']),
                                        )), onTap: () {
                                      inventario.setHistorial(
                                          producto:
                                              inventario.getInventario()[index]
                                                  ['producto'],
                                          precio: filter.format(
                                              inventario.getInventario()[index]
                                                  ['precio']));
                                    }),
                                    DataCell(Center(
                                      child: InkWell(
                                          child: Container(
                                        width: widthScreen * 1 / 12,
                                        child: Text(
                                          inventario
                                              .getInventario()[index]
                                                  ['cantidad']
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                    )),
                                    DataCell(TextField(
                                      textAlign: TextAlign.right,
                                      onTap: () {
                                        columnPedido[index].selection =
                                            TextSelection(
                                                baseOffset: 0,
                                                extentOffset:
                                                    columnPedido[index]
                                                        .text
                                                        .length);
                                      },
                                      onChanged: (v) {
                                        inventario.setInventario(index,
                                            pedido: int.parse(
                                                columnPedido[index].text));
                                      },
                                      controller: columnPedido[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    ))
                                  ])),
                        ))))
          ]));
    });
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
                    leading: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          inventario.deleteInventario(
                              inventario.findIndexInventario(
                                  inventario.getHistorial()['producto']));
                          inventario.setHistorial(producto: "");
                        }),
                    title: Text(
                      inventario.getHistorial()['producto'],
                      textAlign: TextAlign.center,
                    ),
                    isThreeLine: true,
                    subtitle: Column(children: <Widget>[
                      Text('Últimos pedidos'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
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
                              (index) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          InkWell(
                                              child: Container(
                                            width: widthScreen * 2 / 3,
                                            child: Text(inventario
                                                    .getInventario()[index]
                                                ['producto']),
                                          )), onTap: () {
                                        inventario.setHistorial(
                                            producto: inventario
                                                    .getInventario()[index]
                                                ['producto']);
                                      }),
                                      DataCell(
                                          TextField(
                                            textAlign: TextAlign.right,
                                            onTap: () async {
                                              columnInventario[index]
                                                      .selection =
                                                  TextSelection(
                                                      baseOffset: 0,
                                                      extentOffset:
                                                          columnInventario[
                                                                  index]
                                                              .text
                                                              .length);
                                            },
                                            onChanged: (v) {
                                              inventario.setInventario(index,
                                                  cantidad: int.parse(
                                                      columnInventario[index]
                                                          .text));
                                            },
                                            controller: columnInventario[index],
                                            autofocus: false,
                                            keyboardType: TextInputType.number,
                                          ),
                                          placeholder: true)
                                    ],
                                  )),
                        ))))
          ]));
    });
  }

  Widget _resumen(BuildContext context) {
    return Consumer<InventarioProvider>(builder: (context, parent, child) {
      return Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            children: <Widget>[
              Flexible(
                  child: Column(
                children: [
                  Text("Fecha de entrega"),
                  Row(children: [
                    IconButton(
                      icon: Icon(Icons.calendar_today_rounded),
                      onPressed: () => _selectDate(context),
                    ),
                    Text(filterDate(inventario.fechaEntrega))
                  ])
                ],
              )),
              Flexible(
                  child: Column(
                children: [
                  Text("Cliente"),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.contact_page_rounded),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/cliente");
                        },
                      ),
                      Text(cliente.cliente.nombre != ''
                          ? cliente.cliente.nombre
                          : "Seleccione un cliente")
                    ],
                  )
                ],
              )),
              Flexible(
                  child: Row(
                children: [
                  Text("Total del Pedido"),
                  Text("\$${filter.format(inventario.total())}")
                ],
              )),
              Flexible(
                child: Row(
                  children: [
                    RaisedButton(
                      child: Text("Registrar"),
                      onPressed: () {},
                    ),
                    RaisedButton(
                      child: Text("Limpiar Pedido"),
                      onPressed: () {
                        cliente.resetClient();
                        inventario.reset();
                      },
                    ),
                  ],
                ),
              )
            ],
          ));
    });
  }

  /// Función que muestra el datepicker
  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 1),
        lastDate: DateTime(2050),
        builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                primaryColor: colorGenerico,
                colorScheme: ColorScheme.light(primary: colorGenerico),
              ),
              child: child,
            ));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        inventario.fechaEntrega = picked;
      });
  }
}
