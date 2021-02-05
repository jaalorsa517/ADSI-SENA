import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventas/logic/cliente/cliente_provider.dart';
import 'package:ventas/config/utilidades.dart';
import 'package:ventas/ui/widgets/dialog_cliente.dart';

class ScCliente extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScCliente();
  }
}

class _ScCliente extends State<ScCliente> {
  final GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();
  Ciudades _ciudad = Ciudades.Todos;
  int _indexSelected = -1;
  bool _isSelect = false;
  List<bool> _clienteSelect;

  _ScCliente() {
    _clienteSelect = cliente.clientes.length != 0
        ? List.generate(cliente.clientes.length, (index) => false)
        : [];
  }

  void _initialSelection() {
    _clienteSelect = List.generate(cliente.clientes.length, (index) => false);
    _isSelect = false;
  }

  void _snackbar(String message) {
    final snackbar = SnackBar(
        content: Text(message),
        backgroundColor: colorGenerico,
        duration: Duration(seconds: 3));
    _keyScaffold.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _keyScaffold,
        appBar: AppBar(
          title: Text('Cliente'),
          backgroundColor: colorGenerico,
        ),
        body: _listView(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            cliente.nuevoCliente();
            switch (await showDialog<Response>(
                context: context,
                builder: (context) {
                  return DialogCliente(context).modificar(context);
                })) {
              case Response.ok:
                await cliente.clienteCrear();
                _initialSelection();
                _snackbar('Cliente creado!');
                break;
              case Response.cancel:
                _snackbar('Creación cliente cancelado');
                break;
            }
            setState(() {
              _ciudad = Ciudades.Todos;
            });
          },
          child: Icon(Icons.add),
          backgroundColor: colorGenerico,
        ),
        drawer: _drawer(context));
  }

  Widget _listView(BuildContext context) {
    return Consumer<ClienteProvider>(builder: (context, cliente, child) {
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
                      //false and false = Sin seleccion
                      if (!_clienteSelect[index] && !_isSelect) {
                        cliente.cliente = cliente.clientes[index];
                        _indexSelected = index;
                        _clienteSelect[index] = true;
                        _isSelect = true;
                      }
                      //false and true= Seleccionar otro
                      else if (!_clienteSelect[index] && _isSelect) {
                        cliente.cliente = cliente.clientes[index];
                        _clienteSelect[_indexSelected] = false;
                        _clienteSelect[index] = true;
                        _indexSelected = index;
                      }
                      //true and true= Deseleccionar
                      else if (_clienteSelect[index] && _isSelect) {
                        cliente.nuevoCliente();
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
                  title: Text('Venta'),
                  leading: Icon(Icons.shopping_cart),
                  onTap: () async {
                    // await inventario.inventarioProductoOnly(cliente.cliente.id);
                    await pedido.recargarProductoPedido(cliente.cliente.id);
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/venta');
                  }),
              new ListTile(
                  title: Text('Ver información'),
                  leading: Icon(Icons.view_agenda),
                  onTap: () async {
                    await DialogCliente(context).mostrar();
                  }),
              new ListTile(
                title: Text('Actualizar'),
                leading: Icon(Icons.update),
                onTap: () async {
                  switch (await showDialog<Response>(
                      context: context,
                      builder: (context) {
                        return DialogCliente(context).modificar(context);
                      })) {
                    case Response.ok:
                      await cliente.clienteModificar();
                      _initialSelection();
                      Navigator.pop(context);
                      _snackbar('Cliente modificado!');
                      break;
                    case Response.cancel:
                      Navigator.pop(context);
                      _snackbar('Modificacion cliente cancelado');
                      break;
                  }
                  setState(() {
                    _ciudad = Ciudades.Todos;
                  });
                },
              ),
              new ListTile(
                title: Text('Eliminar'),
                leading: Icon(Icons.delete),
                onTap: () async {
                  switch (await showDialog<Response>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('CONFIRMACION'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () async {
                                  await cliente
                                          .clienteBorrar(cliente.cliente.id)
                                      ? _snackbar('Cliente borrado.')
                                      : _snackbar('No se pudo borrar cliente!');
                                  _initialSelection();
                                  setState(() {
                                    _ciudad = Ciudades.Todos;
                                  });
                                  Navigator.pop(context, Response.ok);
                                },
                                child: Text('SI')),
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context, Response.cancel);
                                },
                                child: Text('NO'))
                          ],
                          content:
                              Text('¿Seguro que quieres eliminar el cliente?'),
                        );
                      })) {
                    case Response.ok:
                      Navigator.pop(context);
                      break;
                    case Response.cancel:
                      Navigator.pop(context);
                      _snackbar('Eliminación de cliente cancelada');
                      break;
                  }
                },
              ),
            ]),
          );
        },
        context: context);
  }

  Widget _drawer(BuildContext context) {
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
                      _initialSelection();
                      setState(() {
                        _ciudad = Ciudades.Todos;
                      });
                      Navigator.pop(context);
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
              _initialSelection();
              setState(() {
                _ciudad = value;
              });
              Navigator.pop(context);
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
              _initialSelection();
              setState(() {
                _ciudad = value;
              });
              Navigator.pop(context);
            }),
      )),
      Flexible(
          child: ListTile(
        title: Text('Betania'),
        leading: Radio(
            value: Ciudades.Betania,
            groupValue: _ciudad,
            onChanged: (Ciudades value) async {
              await cliente.clienteForCity('BETANIA');
              _initialSelection();
              setState(() {
                _ciudad = value;
              });
              Navigator.pop(context);
            }),
      )),
      Flexible(
          child: ListTile(
        title: Text('Hispania'),
        leading: Radio(
            value: Ciudades.Hispania,
            groupValue: _ciudad,
            onChanged: (Ciudades value) async {
              await cliente.clienteForCity('HISPANIA');
              _initialSelection();
              setState(() {
                _ciudad = value;
              });
              Navigator.pop(context);
            }),
      )),
      Flexible(
          child: ListTile(
        title: Text('Jardin'),
        leading: Radio(
            value: Ciudades.Jardin,
            groupValue: _ciudad,
            onChanged: (Ciudades value) async {
              await cliente.clienteForCity('JARDIN');
              _initialSelection();
              setState(() {
                _ciudad = value;
              });
              Navigator.pop(context);
            }),
      )),
      Flexible(
          child: ListTile(
        title: Text('Santa Ines'),
        leading: Radio(
            value: Ciudades.SantaInes,
            groupValue: _ciudad,
            onChanged: (Ciudades value) async {
              await cliente.clienteForCity('SANTA INES');
              _initialSelection();
              setState(() {
                _ciudad = value;
              });
              Navigator.pop(context);
            }),
      )),
      Flexible(
          child: ListTile(
        title: Text('Santa Rita'),
        leading: Radio(
            value: Ciudades.SantaRita,
            groupValue: _ciudad,
            onChanged: (Ciudades value) async {
              await cliente.clienteForCity('SANTA RITA');
              _initialSelection();
              setState(() {
                _ciudad = value;
              });
              Navigator.pop(context);
            }),
      )),
      Flexible(
          child: ListTile(
        title: Text('Taparto'),
        leading: Radio(
            value: Ciudades.Taparto,
            groupValue: _ciudad,
            onChanged: (Ciudades value) async {
              await cliente.clienteForCity('TAPARTO');
              _initialSelection();
              setState(() {
                _ciudad = value;
              });
              Navigator.pop(context);
            }),
      )),
    ]));
  }
}
