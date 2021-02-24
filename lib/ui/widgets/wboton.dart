import "package:flutter/material.dart";
import 'package:edertiz/config/utilidades.dart';

class WBoton extends StatefulWidget {
  final String nom;
  final event;
  WBoton(this.nom, this.event);
  @override
  State<StatefulWidget> createState() {
    return _WBoton(this.nom, this.event);
  }
}

class _WBoton extends State<WBoton> {
  String nom;
  var event;
  _WBoton(this.nom, this.event);
  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () {
        Navigator.pushNamed(context, this.event);
      },
      child: Text(
        this.nom,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      color: colorGenerico,
      textColor: Colors.white,
    );
  }
}
