import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:ventas/logic/loaddata.dart';
import 'package:ventas/ui/widgets/wlistCliente.dart';

class sc_cliente extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _sc_cliente();
  }
}

class _sc_cliente extends State<sc_cliente> {
  loadData driver;
  int _select = 0;
  List<ItemModel> clientes = [];
  List<Widget> _widgets = [];

  @override
  Widget build(BuildContext context) {
    driver = loadData(DefaultAssetBundle.of(context));
    _widgets.add(FutureBuilder<List>(
        future: driver.getCliente(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.data == null)
            return Text('DATOS NULOS');
          else {
            for (int i = 0; i < snapshot.data.length; i++) {
              clientes.add(ItemModel(
                  negocio: snapshot.data[i].negocio,
                  nombre: snapshot.data[i].nombre,
                  bodyModel: BodyModel(
                      ciudad: snapshot.data[i].ciudad,
                      direccion: snapshot.data[i].direccion,
                      identificacion: snapshot.data[i].identificacion,
                      telefono: snapshot.data[i].telefono,
                      email: snapshot.data[i].email)));
            }
            return wlistCliente(this.clientes,key: GlobalKey(),);
          }
        }));
    _widgets.add(Text('Add'));
    _widgets.add(Text('Find'));

    return new Scaffold(
      appBar: AppBar(
          title: Text(
            'CLIENTE',
            textAlign: TextAlign.left,
          ),
          backgroundColor: Colors.green),
      body: _widgets.elementAt(_select),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), title: Text('Ver')),
            BottomNavigationBarItem(
                icon: Icon(Icons.add), title: Text('Agregar')),
            BottomNavigationBarItem(
                icon: Icon(Icons.find_in_page), title: Text('Buscar')),
          ],
          currentIndex: _select,
          selectedItemColor: Colors.green,
          onTap: (index) {
            setState(() {
              _select = index;
            });
          }),
    );
  }
}
