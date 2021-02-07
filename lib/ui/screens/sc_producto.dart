import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventas/config/utilidades.dart';
import 'package:ventas/logic/producto/producto_provider.dart';
import 'package:ventas/ui/widgets/dialog_producto.dart';

class ScProducto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScProducto();
  }
}

class _ScProducto extends State<ScProducto> {
  final GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();
  int _indexSelected = -1;
  bool _isSelect = false;
  List<bool> _productoSelect;
  bool _isFind = false;

  _ScProducto() {
    _productoSelect = producto.productos.length != 0
        ? List.generate(producto.productos.length, (index) => false)
        : [];
  }

  void _initialSelection() {
    _productoSelect =
        List.generate(producto.productos.length, (index) => false);
    _isSelect = false;
  }

  void _snackbar(String message) {
    final snackbar = SnackBar(
        content: Text(message),
        backgroundColor: colorGenerico,
        duration: Duration(seconds: 2));
    _keyScaffold.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyScaffold,
      appBar: _busqueda(),
      body: _listView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          producto.nuevoProducto();
          switch (await showDialog<Response>(
              context: context,
              builder: (context) {
                return DialogProducto(context).modificar(context);
              })) {
            case Response.ok:
              await producto.productoCrear();
              _initialSelection();
              _snackbar('Producto creado!');
              break;
            case Response.cancel:
              _snackbar('Creación producto cancelado');
              break;
          }
        },
        child: Icon(Icons.add),
        backgroundColor: colorGenerico,
      ),
    );
  }

  Widget _listView(BuildContext context) {
    return Consumer<ProductoProvider>(builder: (context, producto, child) {
      if (producto.productos == null) {
        return CircularProgressIndicator();
      }
      if (producto.productos.length == 0) {
        return Text('SIN DATOS');
      }
      return ListView.builder(
          itemCount: producto.productos.length,
          itemBuilder: (context, index) {
            return Container(
                color: _productoSelect[index] ? colorGenerico : Colors.white,
                child: ListTile(
                  enabled: true,
                  title: Text(producto.productos[index].nombre),
                  trailing: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      if (inventario.findIndexInventario(
                              producto.productos[index].nombre) ==
                          null) {
                        if (inventario.getInventario()[0]['producto'] != "") {
                          inventario.addInventario(
                              fechaHoy,
                              producto.productos[index].nombre,
                              0,
                              producto.productos[index].precio);
                        } else {
                          inventario.setInventario(0,
                              fecha: fechaHoy,
                              producto: producto.productos[index].nombre,
                              cantidad: 0,
                              precio: producto.productos[index].precio);
                        }
                        _snackbar("Producto agregado al carrito");
                      } else {
                        _snackbar("Este producto ya está en el inventario");
                      }
                    },
                  ),
                  onTap: () {
                    setState(() {
                      //false and false = Sin seleccion
                      if (!_productoSelect[index] && !_isSelect) {
                        producto.producto = producto.productos[index];
                        _indexSelected = index;
                        _productoSelect[index] = true;
                        _isSelect = true;
                      }
                      //false and true= Seleccionar otro
                      else if (!_productoSelect[index] && _isSelect) {
                        producto.producto = producto.productos[index];
                        _productoSelect[_indexSelected] = false;
                        _productoSelect[index] = true;
                        _indexSelected = index;
                      }
                      //true and true= Deseleccionar
                      else if (_productoSelect[index] && _isSelect) {
                        producto.nuevoProducto();
                        _productoSelect[index] = false;
                        _isSelect = false;
                        _indexSelected = -1;
                      }
                    });
                  },
                  onLongPress: () {
                    if (_isSelect && _productoSelect[index]) {
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
                    await DialogProducto(context).mostrar();
                  }),
              new ListTile(
                title: Text('Actualizar'),
                leading: Icon(Icons.update),
                onTap: () async {
                  switch (await showDialog<Response>(
                      context: context,
                      builder: (context) {
                        return DialogProducto(context).modificar(context);
                      })) {
                    case Response.ok:
                      await producto.productoModificar();
                      _initialSelection();
                      Navigator.pop(context);
                      _snackbar('Producto modificado!');
                      break;
                    case Response.cancel:
                      Navigator.pop(context);
                      _snackbar('Modificacion producto cancelado');
                      break;
                  }
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
                                    await producto.productoBorrar(
                                            producto.producto.id)
                                        ? _snackbar('Producto borrado.')
                                        : _snackbar(
                                            'No se pudo borrar producto!');
                                    _initialSelection();
                                    Navigator.pop(context, Response.ok);
                                  },
                                  child: Text('SI')),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context, Response.cancel);
                                  },
                                  child: Text('NO'))
                            ],
                            content: Text(
                                '¿Seguro que quieres eliminar el producto?'),
                          );
                        })) {
                      case Response.ok:
                        Navigator.pop(context);
                        break;
                      case Response.cancel:
                        Navigator.pop(context);
                        _snackbar('Eliminación de producto cancelada');
                        break;
                    }
                  }),
            ]),
          );
        },
        context: context);
  }

  AppBar _busqueda() {
    TextEditingController _find = TextEditingController();
    if (_isFind) {
      return AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    flex: 1,
                    child: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () async {
                          producto.loadProducto();
                          setState(() {
                            _isFind = false;
                          });
                        })),
                Flexible(
                    flex: 4,
                    child: TextField(
                      autofocus: true,
                      controller: _find,
                      decoration: InputDecoration(
                        hintText: 'Buscar',
                      ),
                      onChanged: (value) async {
                        await producto.productoForName(value);
                      },
                    )),
              ]),
          backgroundColor: colorGenerico);
    } else {
      return AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(flex: 4, child: Text('Producto')),
                Flexible(
                    flex: 1,
                    child: IconButton(
                        icon: Icon(Icons.find_in_page),
                        onPressed: () {
                          setState(() {
                            _isFind = true;
                          });
                        }))
              ]),
          backgroundColor: colorGenerico);
    }
  }
}
