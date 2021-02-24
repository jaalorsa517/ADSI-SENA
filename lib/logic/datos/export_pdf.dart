import 'dart:io';
import 'package:esys_flutter_share/esys_flutter_share.dart' as sh;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:edertiz/config/utilidades.dart';
import 'package:edertiz/models/venta/pedido/pedidos.dart';

Future<bool> writeOfPdf(pw.Document document) async {
  List<Map> pedido = await Pedidos.readPedidoToday();

  if (pedido.length > 0) {
    document.addPage(pw.MultiPage(
        header: (context) => pw.Padding(
            padding: pw.EdgeInsets.all(15),
            child: pw.Center(child: pw.Text(fechaHoy))),
        footer: (context) =>
            pw.Center(child: pw.Text(context.pageNumber.toString())),
        pageFormat: PdfPageFormat.letter,
        margin: pw.EdgeInsets.fromLTRB(60, 40, 60, 40),
        build: (pw.Context context) => _toDatos(pedido)));
    return true;
  }
  return false;
}

Future<String> writePdf() async {
  pw.Document pdf = pw.Document();
  if (await writeOfPdf(pdf)) {
    Directory documentDirectory = await getExternalStorageDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/pedidos gralac.pdf");
    file.writeAsBytesSync(await pdf.save());

    sh.Share.file("Pedidos Gralac", "Pedidos Gralac.pdf", await pdf.save(),
        "application/pdf");
    return "";
  } else
    return "No se pudo generar el archivo";
}

List<pw.Widget> _toDatos(List<Map> list) {
  final style = pw.TextStyle(
    fontSize: 12,
    letterSpacing: 1,
  );
  List<pw.Widget> datos = List();

  for (int i = 0; i < list.length; i++) {
    //Ciclo para recorrer por ciudades
    datos.add(pw.Center(
        child: pw.Text(list[i]['ciudad'].toUpperCase(),
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))));
    for (int j = 0; j < list[i]['clientes'].length; j++) {
      //Ciclo para recorrer por clientes
      for (int k = 0; k < list[i]['clientes'][j]['fechaEntrega'].length; k++) {
        //Ciclo para recorrer por fecha de entrega
        datos.add(pw.Row(children: [
          pw.Text("FECHA ENTREGA: ",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text(list[i]['clientes'][j]['fechaEntrega'][k]['fecha'])
        ]));
        datos.add(pw.Row(children: [
          pw.Text("NEGOCIO: ",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text(list[i]['clientes'][j]['negocio'])
        ]));
        datos.add(pw.Row(children: [
          pw.Text("ADMIN: ",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text(list[i]['clientes'][j]['admin'])
        ]));
        datos.add(pw.Table.fromTextArray(
            //Ciclo para recorrer por productos
            data: List.generate(
                list[i]['clientes'][j]['fechaEntrega'][k]['productos'].length,
                (l) {
              return list[i]['clientes'][j]['fechaEntrega'][k]['productos']
                  .toList()[l]
                  .toList();
            }),
            cellStyle: style,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              2: pw.Alignment.centerRight
            },
            headers: ['CODIGO', 'PRODUCTO', 'CANTIDAD'],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold)));
        datos.add(pw.Text("\n"));
      }
    }
  }
  return datos;
}
