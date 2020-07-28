import "package:flutter/material.dart";

class wboton extends StatefulWidget {
  String nom;
  var event;
  wboton(this.nom, this.event);
  @override
  State<StatefulWidget> createState() {
    return _wboton(this.nom, this.event);
  }
}

class _wboton extends State<wboton> {
  String nom;
  var event;
  _wboton(this.nom, this.event);
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
