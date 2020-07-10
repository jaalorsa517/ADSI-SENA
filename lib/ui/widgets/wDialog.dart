import 'package:flutter/material.dart';

import '../../config/variables.dart';

class wDialog extends Dialog {
  BuildContext _context;
  bool _isNew;
  TextEditingController _nit,
      _nombre,
      _admin,
      _telefono,
      _email,
      _direccion,
      _ciudad;
  wDialog(this._context, [this._isNew = false]) {
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
  Future modificar() async {
    return await showDialog(
        context: _context,
        builder: (context) {
          return SimpleDialog(
            title: Center(child: Text('CLIENTE')),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      color: colorGenerico,
                      child: Text('Confirmar'),
                      onPressed: () async {
                        if (_nombre.text != '' && _ciudad.text != '') {
                          cliente.cliente.nit = this._nit.text;
                          cliente.cliente.nombre = this._nombre.text;
                          cliente.cliente.representante = this._admin.text;
                          cliente.cliente.telefono = this._telefono.text;
                          cliente.cliente.email = this._email.text;
                          cliente.cliente.direccion = this._direccion.text;
                          cliente.cliente.ciudad =
                              this._ciudad.text.toUpperCase();
                          if (this._isNew) {
                            if (await cliente.clienteCrear()) {
                              print('Cliente creado');
                            } else {
                              print('Error al crear el cliente');
                            }
                          } else {
                            if (await cliente.clienteModificar()) {
                              print('cliente modificado');
                            } else {
                              print('Error al modificar el cliente');
                            }
                          }
                        } else {
                          print(
                              'Hay que pedirle al cliente agregar un nombre y una ciudad');
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                        color: colorGenerico,
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ])
            ],
          );
        });
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
