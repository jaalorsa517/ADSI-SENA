import 'dart:io';
import 'dart:ui';
import 'package:esys_flutter_share/esys_flutter_share.dart' as sh;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final pdf = pw.Document();

writeOfPdf() {
  final style = pw.TextStyle(
    fontSize: 12,
    letterSpacing: 1,
  );
  // List element = List.generate(20, (int i) => "esto es una prueba en $i");
  List<List> element = List.generate(
      50, (int i) => [1002, "Producto que voy a probar y ver", 3]);
  pdf.addPage(pw.MultiPage(
      header: (context) => pw.Padding(
          padding: pw.EdgeInsets.all(15),
          child: pw.Center(child: pw.Text("Fecha de hoy"))),
      footer: (context) =>
          pw.Center(child: pw.Text(context.pageNumber.toString())),
      pageFormat: PdfPageFormat.letter,
      margin: pw.EdgeInsets.fromLTRB(60, 40, 60, 40),
      build: (pw.Context context) {
        return [
          pw.Table.fromTextArray(
              data: element,
              cellStyle: style,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                2: pw.Alignment.centerRight
              },
              headers: ['CODIGO', 'PRODUCTO', 'CANTIDAD'],
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold))
        ];
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
