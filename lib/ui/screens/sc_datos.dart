import 'package:flutter/material.dart';
import 'package:ventas/config/utilidades.dart';
import 'package:ventas/logic/datos/backup_logic.dart';
import 'package:ventas/logic/datos/export_pdf.dart';

class ScDatos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScDatos();
  }
}

class _ScDatos extends State<ScDatos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Datos'), backgroundColor: colorGenerico),
      body: Column(
        children: [
          RaisedButton(
              child: Text('Backup'),
              color: colorGenerico,
              onPressed: () async {
                await BackUpLogic.backUpDo()
                    .then((value) => print('Copia correcta'))
                    .catchError((onError) => print('Error $onError'));
              }),
          RaisedButton(
              child: Text('Export a pdf'),
              color: colorGenerico,
              onPressed: () async {
                writeOfPdf();
                await writePdf();
              }),
        ],
      ),
    );
  }
}
