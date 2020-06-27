import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ventas/ui/widgets/wcombo.dart';

class BodyModel {
  String identificacion, direccion, ciudad, telefono, email;
  BodyModel(
      {this.identificacion,
      this.direccion,
      this.ciudad,
      this.telefono,
      this.email});
}

class ItemModel {
  bool isExpanded;
  BodyModel bodyModel;
  String negocio, nombre;
  ItemModel(
      {this.isExpanded: false, this.bodyModel, this.negocio, this.nombre});
}

class wlistCliente extends StatefulWidget {
  List<ItemModel> datos;
  wlistCliente(this.datos, {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _wlistCliente(this.datos);
  }
}

class _wlistCliente extends State<wlistCliente> {
  List<ItemModel> datos;
  _wlistCliente(this.datos);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ExpansionPanelList(
            animationDuration: Duration(milliseconds: 50),
            children: [
              ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Text(datos[index].negocio,
                              style: TextStyle(fontSize: 14)),
                          Text(datos[index].nombre,
                              style: TextStyle(fontSize: 14))
                        ],
                      ),
                    );
                  },
                  isExpanded: datos[index].isExpanded,
                  body: Container(
                      child: Column(children: [
                    Text(
                        'Identificación:${datos[index].bodyModel.identificacion}',
                        style: TextStyle(fontSize: 10)),
                    Text('Direccion:${datos[index].bodyModel.direccion}',
                        style: TextStyle(fontSize: 10)),
                    Text('Ciudad:${datos[index].bodyModel.ciudad}',
                        style: TextStyle(fontSize: 10)),
                    Text('Telefono:${datos[index].bodyModel.telefono}',
                        style: TextStyle(fontSize: 10)),
                    Text('Email:${datos[index].bodyModel.email}',
                        style: TextStyle(fontSize: 10))
                  ])))
            ],
            expansionCallback: (int item, bool status) {
              setState(() {
                datos[index].isExpanded = !datos[index].isExpanded;
              });
            },
          );
        },
        itemCount: datos.length,
      ),
    );
  }
}
