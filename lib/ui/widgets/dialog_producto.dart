import 'package:flutter/material.dart';

import '../../config/utilidades.dart';

class DialogProducto {
  BuildContext _context;
  TextEditingController _nombre, _precio, _iva;

  DialogProducto(this._context) {
    String _controllerPrecio;
    String _controllerIva;
    if (producto.producto.precio != null) {
      _controllerPrecio = producto.producto.precio.toString();
    } else {
      _controllerPrecio = '';
    }
    if (producto.producto.iva != null) {
      _controllerIva = producto.producto.iva.toString();
    } else {
      _controllerIva = '';
    }
    this._nombre = TextEditingController(text: producto.producto.nombre ?? '');
    this._precio = TextEditingController(text: _controllerPrecio);
    this._iva = TextEditingController(text: _controllerIva);
  }

  modificar(context) {
    var _styleButton = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    );
    return SimpleDialog(
        contentPadding: EdgeInsets.all(0),
        title: Center(child: Text('PRODUCTO')),
        children: <Widget>[
          Column(
            children: <Widget>[
              TextField(
                controller: this._nombre,
                decoration: InputDecoration(
                    hintText: 'NOMBRE', contentPadding: EdgeInsets.all(10)),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: this._precio,
                decoration: InputDecoration(
                    hintText: 'PRECIO', contentPadding: EdgeInsets.all(10)),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: this._iva,
                decoration: InputDecoration(
                    hintText: 'IVA', contentPadding: EdgeInsets.all(10)),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
                Expanded(
                    child: SimpleDialogOption(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Aceptar',
                    style: _styleButton,
                  ),
                  onPressed: () async {
                    if (_nombre.text != '') {
                      producto.updateCliente(
                          _nombre.text.toUpperCase(),
                          _precio.text.isEmpty ? 0 : int.parse(_precio.text),
                          _iva.text.isEmpty ? 0 : double.parse(_iva.text));
                      Navigator.pop(_context, Response.ok);
                    } else {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Campos vacíos'),
                              content:
                                  Text('El campo NOMBRE no puede ser vacío'),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            );
                          });
                    }
                  },
                )),
                Expanded(
                  child: SimpleDialogOption(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Cancelar',
                        style: _styleButton,
                      ),
                      onPressed: () {
                        Navigator.pop(_context, Response.cancel);
                      }),
                )
              ])
            ],
          )
        ]);
  }

  Future mostrar() async {
    var pad = EdgeInsets.fromLTRB(10, 5, 10, 5);
    return await showDialog(
        context: _context,
        builder: (context) {
          TextStyle titulo =
              new TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
          TextStyle subtitulo = new TextStyle(fontSize: 20);
          return SimpleDialog(
            title: Center(child: Text('PRODUCTO')),
            children: <Widget>[
              Padding(
                padding: pad,
                child: Text(
                  'NOMBRE',
                  style: titulo,
                ),
              ),
              Padding(
                padding: pad,
                child: Text(producto.producto.nombre, style: subtitulo),
              ),
              Padding(
                padding: pad,
                child: Text(
                  'PRECIO',
                  style: titulo,
                ),
              ),
              Padding(
                padding: pad,
                child:
                    Text(producto.producto.precio.toString(), style: subtitulo),
              ),
              Padding(
                padding: pad,
                child: Text(
                  'IVA',
                  style: titulo,
                ),
              ),
              Padding(
                padding: pad,
                child: Text(producto.producto.iva.toString(), style: subtitulo),
              ),
            ],
          );
        });
  }
}
