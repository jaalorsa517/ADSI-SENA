import 'package:flutter/material.dart';

class wDialog extends Dialog {
  BuildContext _context;
  String nit, nombre, admin, telefono, email, direccion;
  TextEditingController _nit, _nombre, _admin, _telefono, _email, _direccion;
  wDialog(this._context,
      {this.nit,
      this.nombre,
      this.admin,
      this.telefono,
      this.email,
      this.direccion}) {
    this._nit = TextEditingController(text: this.nit ?? '');
    this._nombre = TextEditingController(text: this.nombre ?? '');
    this._admin = TextEditingController(text: this.admin ?? '');
    this._telefono = TextEditingController(text: this.telefono ?? '');
    this._email = TextEditingController(text: this.email ?? '');
    this._direccion = TextEditingController(text: this.direccion ?? '');
  }

  Future mostrar() async {
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                        color: Colors.green,
                        child: Text('Confirmar'),
                        onPressed: () {}),
                    FlatButton(
                        color: Colors.green,
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ])
            ],
          );
        });
  }
}
