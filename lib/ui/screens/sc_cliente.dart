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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cliente'),
          backgroundColor: colorGenerico,
        ),
        body: _listView(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await wDialog(context, true).modificar();
          },
          child: Icon(Icons.add),
          backgroundColor: colorGenerico,
        ),
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
                color: _clienteSelect[index] ? colorGenerico : Colors.white,
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
                      } else if (!_clienteSelect[index] && _isSelect) {
                        cliente.cliente = cliente.clientes[index];
                        _clienteSelect[_indexSelected] = false;
                        _clienteSelect[index] = true;
                        _indexSelected = index;
                      } else if (_clienteSelect[index] && _isSelect) {
                        _clienteSelect[index] = false;
                        _isSelect = false;
                        _indexSelected = -1;
                      }
                    });
                  },
                  onLongPress: () {
                    if (_isSelect && _clienteSelect[index]) {
                      _bottomSheet(context);
                    }
                  },
                ));
          });
    });
  }

  Future<Widget> _bottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
        builder: (BuildContext context) {
          return Container(
            child: Wrap(children: <Widget>[
              new ListTile(
                  title: Text('Ver información'),
                  leading: Icon(Icons.view_agenda),
                  onTap: () async {
                    await wDialog(context).mostrar();
                  }),
              new ListTile(
                title: Text('Actualizar'),
                leading: Icon(Icons.update),
                onTap: () async {
                  await wDialog(context).modificar();
                },
              ),
              new ListTile(
                title: Text('Eliminar'),
                leading: Icon(Icons.delete),
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('CONFIRMACION'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () async {
                                  await cliente
                                          .clienteBorrar(cliente.cliente.id)
                                      ? SnackBar(
                                          content: Text('Cliente borrado'))
                                      : SnackBar(
                                          content: Text('No se pudo borrar'));
                                },
                                child: Text('SI')),
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('NO'))
                          ],
                          content:
                              Text('¿Seguro que quieres eliminar el cliente?'),
                        );
                      });
                },
              ),
            ]),
          );
        },
        context: context);
  }

  Widget _drawer() {
    return Drawer(
        child: Column(children: <Widget>[
      Flexible(
          flex: 2,
          child: Stack(
            children: <Widget>[
              Container(decoration: BoxDecoration(color: colorGenerico)),
              Center(
                child: TextField(
                    onSubmitted: (String value) async {
                      await cliente.clienteForName(value);
                      _clienteSelect = List.generate(
                          cliente.clientes.length, (index) => false);
                      _isSelect = false;
                    },
                    decoration: InputDecoration(hintText: 'Buscar')),
              )
            ],
          )),
      Flexible(
          flex: 2,
          child: Text(
            'FILTRAR CIUDAD',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
      Flexible(
          child: ListTile(
        title: Text('Todos'),
        leading: Radio(
            value: Ciudades.Todos,
            groupValue: _ciudad,
            onChanged: (Ciudades value) async {
              await cliente.loadCliente();
              _clienteSelect =
                  List.generate(cliente.clientes.length, (index) => false);
              _isSelect = false;
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
              _clienteSelect =
                  List.generate(cliente.clientes.length, (index) => false);
              _isSelect = false;
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
              _clienteSelect =
                  List.generate(cliente.clientes.length, (index) => false);
              _isSelect = false;
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
                _clienteSelect =
                    List.generate(cliente.clientes.length, (index) => false);
                _isSelect = false;
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
                _clienteSelect =
                    List.generate(cliente.clientes.length, (index) => false);
                _isSelect = false;
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
                _clienteSelect =
                    List.generate(cliente.clientes.length, (index) => false);
                _isSelect = false;
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
                _clienteSelect =
                    List.generate(cliente.clientes.length, (index) => false);
                _isSelect = false;
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
                _clienteSelect =
                    List.generate(cliente.clientes.length, (index) => false);
                _isSelect = false;
              });
            }),
      )),
    ]));
  }
}
