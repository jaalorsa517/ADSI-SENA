import 'package:sqflite/sqlite_api.dart';
import 'package:edertiz/config/setup.dart';
import 'package:edertiz/models/crud.dart';


class Ciudades {

  static Future<List<String>> read() async {
    Database db = await Crud.conectar();
    try {
      List<Map<String, dynamic>> list =
          await db.query(Setup.CIUDAD_TABLE, columns: ['nombre']);
      return List.generate(list.length, (i) => list[i]['nombre']);
    } catch (e) {
      print(e.toString);
      return null;
    }
  }
}
