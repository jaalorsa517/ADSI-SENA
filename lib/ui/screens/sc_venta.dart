import "package:flutter/material.dart";
import 'package:ventas/config/utilidades.dart';

class ScVenta extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScVenta();
  }
}

class _ScVenta extends State<ScVenta> {
  int _vista = 0;
  List<Widget> _pantalla = [];
  _ScVenta() {
    _pantalla = [_venta(), _inventario(), _resumen()];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ventas'),
        backgroundColor: colorGenerico,
      ),
      body: _pantalla[_vista],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: colorGenerico,
          selectedItemColor: Colors.amber[100],
          unselectedItemColor: Colors.white,
          currentIndex: _vista,
          onTap: (i) {
            setState(() {
              _vista = i;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                title: Text(
                  'Venta',
                ),
                icon: Icon(
                  Icons.add_shopping_cart,
                )),
            BottomNavigationBarItem(
                title: Text(
                  'Inventario',
                ),
                icon: Icon(
                  Icons.account_balance_wallet,
                )),
            BottomNavigationBarItem(
                title: Text(
                  'Resumen',
                ),
                icon: Icon(
                  Icons.shopping_cart,
                )),
          ]),
    );
  }

  Widget _venta() {
    return Padding(
        padding: EdgeInsets.all(0),
        child: Column(children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: ListTile(title: Text('algo')),
          ),
          Flexible(
              flex: 7,
              fit: FlexFit.tight,
              child: ListView(
                  children: List.generate(50, (i) => Text('$heightScreen'))))
        ]));
  }

  Widget _inventario() {
    return Text('inventario');
  }

  Widget _resumen() {
    return Text('resumen');
  }
}
