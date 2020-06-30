import 'package:flutter/material.dart';
import 'package:ventas/logic/cliente/cliente_provider.dart';
import 'package:ventas/ui/variables.dart';

class sc_cliente extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _sc_cliente();
  }
}

class _sc_cliente extends State<sc_cliente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cliente'),
      ),
      body: Text('hello_world'),
    );
    ;
  }
}
