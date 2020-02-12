import "package:flutter/material.dart";
import 'package:ventas/ui/screens/sc_producto.dart';
import 'package:ventas/ui/widgets/wcalendar.dart';

class wboton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _wboton();
  }
}

class _wboton extends State<wboton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => sc_producto()));
        });
  }
}
