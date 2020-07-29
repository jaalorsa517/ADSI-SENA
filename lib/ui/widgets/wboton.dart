import "package:flutter/material.dart";

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
      onPressed: () {
        Navigator.pushNamed(context, this.event);
      },
      child: Text(this.nom),
      color: Colors.green,
      textColor: Colors.white,
    );
  }
}
