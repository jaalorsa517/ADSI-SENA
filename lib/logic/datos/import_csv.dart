import 'dart:io';
import 'package:csv/csv.dart';
import 'package:ventas/models/datos/import.dart';

Future<List<List>> _fromCsv(String path) async {
  List csvFile = await new File(path).readAsLines();
  List<List> csvConverted = [];
  final CsvToListConverter converter = CsvToListConverter();
  csvFile.forEach((row) => csvConverted.add(converter.convert(row)[0]));
  return csvConverted;
}

Future<String> importClient(String path) async {
  List<List> rows = await _fromCsv(path);
  bool result;
  if(rows.length > 1 && rows[0].length == 7)
    result = await Import.importClientes(rows);
  else
    result = false;
  if (result == null) return "Hubo un error";
  if (result)
    return "Importación completa";
  else
    return "La estructura del CSV es incorrecta";
}

Future<String> importProduct(String path) async {
  List<List> rows = await _fromCsv(path);
  bool result;
  if(rows.length > 0 && rows[0].length == 4)
    result = await Import.importProductos(rows);
  else
    result = false;
  if (result == null) return "Hubo un error";
  if (result)
    return "Importación completa";
  else
    return "La estructura del CSV es incorrecta";
}
