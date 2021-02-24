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
      fontSize: 20,
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
                decoration: InputDecoration(
                    hintText: 'NIT', contentPadding: EdgeInsets.all(10)),
              ),
              TextField(
                controller: this._nombre,
                decoration: InputDecoration(
                    hintText: 'NOMBRE', contentPadding: EdgeInsets.all(10)),
              ),
              TextField(
                controller: this._admin,
                decoration: InputDecoration(
                    hintText: 'ADMIN', contentPadding: EdgeInsets.all(10)),
              ),
              TextField(
                controller: this._telefono,
                decoration: InputDecoration(
                    hintText: 'TELEFONO', contentPadding: EdgeInsets.all(10)),
              ),
              TextField(
                controller: this._email,
                decoration: InputDecoration(
                    hintText: 'EMAIL', contentPadding: EdgeInsets.all(10)),
              ),
              TextField(
                controller: this._direccion,
                decoration: InputDecoration(
                    hintText: 'DIRECCION', contentPadding: EdgeInsets.all(10)),
              ),
              TextField(
                controller: this._ciudad,
                decoration: InputDecoration(
                    hintText: 'CIUDAD', contentPadding: EdgeInsets.all(10)),
              ),
              Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: SimpleDialogOption(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Aceptar',
                        style: _styleButton,
                      ),
                      onPressed: () async {
                        List cities = await cliente.getCities();
                        if (!cities.contains(_ciudad.text.toUpperCase())) {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('CIUDAD INCORRECTA'),
                                  content: Text(
                                      "El campo CIUDAD debe ser uno de los siguientes:\n" +
                                          "${cities.join(',')}"),
                                  // "ANDES, BETANIA, HISPANIA, JARDIN, SANTA INES, SANTA RITA O TAPARTO"),
                                  actions: <Widget>[
                                    FlatButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                );
                              });
                        } else if (_nombre.text != '' && _ciudad.text != '') {
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
            title: Center(child: Text('CLIENTE')),
            children: <Widget>[
              Padding(
                padding: pad,
                child: Text(
                  'NIT',
                  style: titulo,
                ),
              ),
              Padding(
                padding: pad,
                child: Text(cliente.cliente.nit, style: subtitulo),
              ),
              Padding(
                padding: pad,
                child: Text(
                  'NOMBRE',
                  style: titulo,
                ),
              ),
              Padding(
                padding: pad,
                child: Text(cliente.cliente.nombre, style: subtitulo),
              ),
              Padding(
                padding: pad,
                child: Text(
                  'ADMIN',
                  style: titulo,
                ),
              ),
              Padding(
                padding: pad,
                child: Text(cliente.cliente.representante, style: subtitulo),
              ),
              Padding(
                padding: pad,
                child: Text(
                  'TELEFONO',
                  style: titulo,
                ),
              ),
              Padding(
                padding: pad,
                child: Text(cliente.cliente.telefono, style: subtitulo),
              ),
              Padding(
                padding: pad,
                child: Text(
                  'EMAIL',
                  style: titulo,
                ),
              ),
              Padding(
                padding: pad,
                child: Text(cliente.cliente.email, style: subtitulo),
              ),
              Padding(
                padding: pad,
                child: Text(
                  'DIRECCION',
                  style: titulo,
                ),
              ),
              Padding(
                padding: pad,
                child: Text(cliente.cliente.direccion, style: subtitulo),
              ),
              Padding(
                padding: pad,
                child: Text(
                  'CIUDAD',
                  style: titulo,
                ),
              ),
              Padding(
                padding: pad,
                child: Text(cliente.cliente.ciudad, style: subtitulo),
              ),
            ],
          );
        });
  }
}
