import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventas/logic/cliente/cliente_provider.dart';
import 'package:ventas/ui/variables.dart';
import 'package:ventas/ui/widgets/wDialog.dart';

class sc_cliente extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _sc_cliente();
  }
}

enum Ciudades {
  Todos,
  Andes,
  Betania,
  Hispania,
  Jardin,
  SantaInes,
  SantaRita,
  Taparto
}

class _sc_cliente extends State<sc_cliente> {
  Ciudades _ciudad = Ciudades.Todos;
  int _indexSelected = -1;
  bool _isSelect = false;
  List<bool> _clienteSelect =
      List.generate(cliente.clientes.length, (index) => false);
  int _selectItemBottomNavigator = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cliente'),
          backgroundColor: Colors.green,
        ),
        bottomNavigationBar: _navigatorBottom(),
        body: _listView(context),
        drawer: _drawer());
  }

  Widget _listView(BuildContext context) {
    return Consumer<ClienteProvider>(builder: (_, cliente, __) {
      if (cliente.clientes == null) {
        return CircularProgressIndicator();
      }
      if (cliente.clientes.length == 0) {
        return Text('SIN DATOS');
      }
      return ListView.builder(
          itemCount: cliente.clientes.length,
          itemBuilder: (context, index) {
            return Container(
                color: _clienteSelect[index] ? Colors.green : Colors.white,
                child: ListTile(
                  enabled: true,
                  title: Text(cliente.clientes[index].nombre),
                  onTap: () {
                    setState(() {
                      if (!_clienteSelect[index] && !_isSelect) {
                        cliente.cliente = cliente.clientes[index];
                        _indexSelected = index;
                        _clienteSelect[index] = true;
                        _isSelect = true;
                      } else if (_clienteSelect[index] && _isSelect) {
                        _clienteSelect[index] = false;
                        _isSelect = false;
                        _indexSelected = -1;
                      }
                    });
                  },
                ));
          });
    });
  }

  Widget _drawer() {
    return Drawer(
        child: Column(children: <Widget>[
      Flexible(
          flex: 2,
          child: Stack(
            children: <Widget>[
              Container(decoration: BoxDecoration(color: Colors.green)),
              Center(
                child: TextField(
                    onSubmitted: (String value) async {
                      await cliente.clienteForName(value);
                    },
                    decoration: InputDecoration(hintText: 'Buscar')),
              )
            ],
          )),
      Flexible(flex: 2, child: Text('FILTRAR CIUDAD')),
      Flexible(
          child: ListTile(
        title: Text('Todos'),
        leading: Radio(
            value: Ciudades.Todos,
            groupValue: _ciudad,
            onChanged: (Ciudades value) async {
              await cliente.loadCliente();
              setState(() {
                _ciudad = value;
              });
            }),
      )),
      Flexible(
          child: ListTile(
        title: Text('Andes'),
        leading: Radio(
            value: Ciudades.Andes,
            groupValue: _ciudad,
            onChanged: (Ciudades value) async {
              await cliente.clienteForCity('ANDES');
              setState(() {
                _ciudad = value;
              });
            }),
      )),
      Flexible(
          child: ListTile(
        title: Text('Betania'),
        leading: Radio(
            value: Ciudades.Betania,
            groupValue: _ciudad,
            onChanged: (Ciudades value) {
              cliente.clienteForCity('BETANIA');
              setState(() {
                _ciudad = value;
              });
            }),
      )),
      Flexible(
          child: ListTile(
        title: Text('Hispania'),
        leading: Radio(
            value: Ciudades.Hispania,
            groupValue: _ciudad,
            onChanged: (Ciudades value) {
              setState(() {
                _ciudad = value;
                cliente.clienteForCity('HISPANIA');
              });
            }),
      )),
      Flexible(
          child: ListTile(
        title: Text('Jardin'),
        leading: Radio(
            value: Ciudades.Jardin,
            groupValue: _ciudad,
            onChanged: (Ciudades value) {
              setState(() {
                _ciudad = value;
                cliente.clienteForCity('JARDIN');
              });
            }),
      )),
      Flexible(
          child: ListTile(
        title: Text('Santa Ines'),
        leading: Radio(
            value: Ciudades.SantaInes,
            groupValue: _ciudad,
            onChanged: (Ciudades value) {
              setState(() {
                _ciudad = value;
                cliente.clienteForCity('SANTA INES');
              });
            }),
      )),
      Flexible(
          child: ListTile(
        title: Text('Santa Rita'),
        leading: Radio(
            value: Ciudades.SantaRita,
            groupValue: _ciudad,
            onChanged: (Ciudades value) {
              setState(() {
                _ciudad = value;
                cliente.clienteForCity('SANTA RITA');
              });
            }),
      )),
      Flexible(
          child: ListTile(
        title: Text('Taparto'),
        leading: Radio(
            value: Ciudades.Taparto,
            groupValue: _ciudad,
            onChanged: (Ciudades value) {
              setState(() {
                _ciudad = value;
                cliente.clienteForCity('TAPARTO');
              });
            }),
      )),
    ]));
  }

  Widget _navigatorBottom() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          title: Text('Nuevo'),
        ),
        BottomNavigationBarItem(icon: Icon(Icons.info), title: Text('Info')),
      ],
      currentIndex: _selectItemBottomNavigator,
      selectedItemColor: Colors.blueGrey,
      unselectedItemColor: Colors.blueGrey,
      onTap: (int index) async {
        if (index == 0) await wDialog(context).mostrar();
        if (index == 1) {
          await wDialog(
            context,
            nit: cliente.cliente.nit,
            nombre: cliente.cliente.nombre,
            admin: cliente.cliente.representante,
            telefono: cliente.cliente.telefono,
            email: cliente.cliente.email,
            direccion: cliente.cliente.direccion,
          ).mostrar();
        }
      },
    );
  }
}
