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
      backgroundColor: colorGenerico,
      fontSize: 18,
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
                decoration: InputDecoration(hintText: 'NOMBRE'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: this._precio,
                decoration: InputDecoration(hintText: 'PRECIO'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: this._iva,
                decoration: InputDecoration(hintText: 'IVA'),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
                Expanded(
                    child: SimpleDialogOption(
                  padding: EdgeInsets.all(0),
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
    return await showDialog(
        context: _context,
        builder: (context) {
          TextStyle titulo =
              new TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
          TextStyle subtitulo = new TextStyle(fontSize: 16);
          return SimpleDialog(
            title: Center(child: Text('PRODUCTO')),
            children: <Widget>[
              Text(
                'NOMBRE',
                style: titulo,
              ),
              Text(producto.producto.nombre, style: subtitulo),
              Text(
                'PRECIO',
                style: titulo,
              ),
              Text(producto.producto.precio.toString(), style: subtitulo),
              Text(
                'IVA',
                style: titulo,
              ),
              Text(producto.producto.iva.toString(), style: subtitulo),
            ],
          );
        });
  }
}
