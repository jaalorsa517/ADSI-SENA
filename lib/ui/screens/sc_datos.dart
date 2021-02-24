import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:edertiz/config/utilidades.dart';
import 'package:edertiz/logic/datos/export_pdf.dart';
import 'package:edertiz/logic/datos/import_csv.dart';

class ScDatos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScDatos();
  }
}

class _ScDatos extends State<ScDatos> {
  final GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();
  void _snackbar(String message) {
    final snackbar = SnackBar(
        content: Text(message),
        backgroundColor: colorGenerico,
        duration: Duration(seconds: 1));
    _keyScaffold.currentState.showSnackBar(snackbar);
  }

  Widget _raisedButton(String text, var func) {
    return RaisedButton(
      color: colorGenerico,
      child: Text(text),
      onPressed: () async {
        FilePickerResult result = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: [".csv"]);
        if (result != null) {
          String msg = await func((result.files.single.path));
          Navigator.pop(context);
          _snackbar(msg);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyScaffold,
      appBar: AppBar(title: Text('Datos'), backgroundColor: colorGenerico),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('Importar...',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  color: colorGenerico,
                  textColor: Colors.white,
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                              title: Text("Importar desde CSV"),
                              children: [
                                _raisedButton("Importar Clientes", importClient),
                                _raisedButton("Importar Productos", importProduct)
                              ],
                            ));
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('Export a pdf',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  color: colorGenerico,
                  textColor: Colors.white,
                  onPressed: () async {
                    _snackbar(await writePdf());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
