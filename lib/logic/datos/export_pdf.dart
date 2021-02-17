import 'dart:io';
import 'dart:ui';
import 'package:esys_flutter_share/esys_flutter_share.dart' as sh;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ventas/config/utilidades.dart';
import 'package:ventas/models/venta/pedido/pedidos.dart';

final pdf = pw.Document();

writeOfPdf() async {
  List<Map> pedido = await Pedidos.readPedidoToday();

  pdf.addPage(pw.MultiPage(
      header: (context) => pw.Padding(
          padding: pw.EdgeInsets.all(15),
          child: pw.Center(child: pw.Text(fechaHoy))),
      footer: (context) =>
          pw.Center(child: pw.Text(context.pageNumber.toString())),
      pageFormat: PdfPageFormat.letter,
      margin: pw.EdgeInsets.fromLTRB(60, 40, 60, 40),
      build: (pw.Context context) {
        return _toDatos(pedido);
      }));
}

Future writePdf() async {
  // Directory documentDirectory = await getApplicationDocumentsDirectory();
  Directory documentDirectory = await getExternalStorageDirectory();
  String documentPath = documentDirectory.path;
  // sh.Share.file(
  //     "Prueba", "nombrePrueba.pdf", await pdf.save(), "application/pdf");
  print(documentPath);
  File file = File("$documentPath/example.pdf");
  file.writeAsBytesSync(await pdf.save());
}

List _toDatos(List<Map> list) {
  final style = pw.TextStyle(
    fontSize: 12,
    letterSpacing: 1,
  );
  List datos = [];

  for (int i = 0; i < list.length; i++) {
    //Ciclo para recorrer por ciudades
    datos.add(pw.Center(
        child: pw.Text(list[i]['ciudad'].toUpperCase(),
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))));
    for (int j = 0; j < list[i]['clientes'].length; j++) {
      //Ciclo para recorrer por clientes
      for (int k = 0; k < list[i]['clientes'][j]['fechaEntrega'].length; k++) {
        //Ciclo para recorrer por fecha de entrega
        datos.add(pw.Text(list[i]['clientes'][j]['fechaEntrega'][k]['fecha']));
        datos.add(pw.Text("NEGOCIO: ${list[i]['clientes'][j]['negocio']}"));
        datos.add(pw.Text("ADMIN: ${list[i]['clientes'][j]['admin']}"));
        datos.add(pw.Table.fromTextArray(
            //Ciclo para recorrer por productos
            data: List.generate(
                list[i]['clientes'][j]['fechaEntrega'][k]['productos'].length,
                (l) => list[i]['clientes'][j]['fechaEntrega'][k]['productos'][l]
                    .values),
            cellStyle: style,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              2: pw.Alignment.centerRight
            },
            headers: ['CODIGO', 'PRODUCTO', 'CANTIDAD'],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold)));
      }
    }
  }
}
