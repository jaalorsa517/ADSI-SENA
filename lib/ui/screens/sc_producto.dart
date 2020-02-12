import 'package:flutter/material.dart';
import 'package:ventas/ui/widgets/wcalendar.dart';

class sc_producto extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text('Segunda'),),
      body: wcalendar()
    );
  }

}