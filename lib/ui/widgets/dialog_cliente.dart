import 'package:flutter/material.dart';

import '../../config/utilidades.dart';

class DialogCliente {
  BuildContext _context;
  TextEditingController _nit,
      _nombre,
      _admin,
      _telefono,
      _email,
      _direccion,
      _ciudad;

  DialogCliente(this._context) {
    this._nit = TextEditingController(text: cliente.cliente.nit ?? '');
    this._nombre = TextEditingController(text: cliente.cliente.nombre ?? '');
    this._admin =
        TextEditingController(text: cliente.cliente.representante ?? '');
    this._telefono =
        TextEditingController(text: cliente.cliente.telefono ?? '');
    this._email = TextEditingController(text: cliente.cliente.email ?? '');
    this._direccion =
        TextEditingController(text: cliente.cliente.direccion ?? '');
    this._ciudad = TextEditingController(text: cliente.cliente.ciudad ?? '');
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
        title: Center(child: Text('CLIENTE')),
        children: <Widget>[
          Column(
            children: <Widget>[
              TextField(
                controller: this._nit,
                decoration: InputDecoration(hintText: 'NIT'),
              ),
              TextField(
                controller: this._nombre,
                decoration: InputDecoration(hintText: 'NOMBRE'),
              ),
              TextField(
                controller: this._admin,
                decoration: InputDecoration(hintText: 'ADMIN'),
              ),
              TextField(
                controller: this._telefono,
                decoration: InputDecoration(hintText: 'TELEFONO'),
              ),
              TextField(
                controller: this._email,
                decoration: InputDecoration(hintText: 'EMAIL'),
              ),
              TextField(
                controller: this._direccion,
                decoration: InputDecoration(hintText: 'DIRECCION'),
              ),
              TextField(
                controller: this._ciudad,
                decoration: InputDecoration(hintText: 'CIUDAD'),
              ),
              Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: SimpleDialogOption(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Aceptar',
                        style: _styleButton,
                      ),
                      onPressed: () async {
                        if (_nombre.text != '' && _ciudad.text != '') {
                          cliente.updateCliente(
                              _nit.text,
                              capitalize(_nombre.text),
                              capitalize(_admin.text),
                              _telefono.text,
                              _email.text,
                              _direccion.text,
                              _ciudad.text.toUpperCase());
                          Navigator.pop(_context, Response.ok);
                        } else {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Campos vacíos'),
                                  content: Text(
                                      'El campo NOMBRE y el campo CIUDAD no puede ser vacío'),
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
            title: Center(child: Text('CLIENTE')),
            children: <Widget>[
              Text(
                'NIT',
                style: titulo,
              ),
              Text(cliente.cliente.nit, style: subtitulo),
              Text(
                'NOMBRE',
                style: titulo,
              ),
              Text(cliente.cliente.nombre, style: subtitulo),
              Text(
                'ADMIN',
                style: titulo,
              ),
              Text(cliente.cliente.representante, style: subtitulo),
              Text(
                'TELEFONO',
                style: titulo,
              ),
              Text(cliente.cliente.telefono, style: subtitulo),
              Text(
                'EMAIL',
                style: titulo,
              ),
              Text(cliente.cliente.email, style: subtitulo),
              Text(
                'DIRECCION',
                style: titulo,
              ),
              Text(cliente.cliente.direccion, style: subtitulo),
              Text(
                'CIUDAD',
                style: titulo,
              ),
              Text(cliente.cliente.ciudad, style: subtitulo),
            ],
          );
        });
  }
}
