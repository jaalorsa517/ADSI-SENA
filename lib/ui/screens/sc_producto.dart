import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventas/config/utilidades.dart';
import 'package:ventas/logic/producto/producto_provider.dart';

class ScProducto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScProducto();
  }
}

class _ScProducto extends State<ScProducto> {
  int _indexSelected = -1;
  bool _isSelect = false;
  List<bool> _productoSelect =
      List.generate(cliente.clientes.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Producto'), backgroundColor: colorGenerico),
      body: _listView(context),
    );
  }

  Widget _listView(BuildContext context) {
    return Consumer<ProductoProvider>(builder: (_, producto, __) {
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
                  onTap: () {
                    setState(() {
                      if (!_productoSelect[index] && !_isSelect) {
                        producto.producto = producto.productos[index];
                        _indexSelected = index;
                        _productoSelect[index] = true;
                        _isSelect = true;
                      } else if (!_productoSelect[index] && _isSelect) {
                        producto.producto = producto.productos[index];
                        _productoSelect[_indexSelected] = false;
                        _productoSelect[index] = true;
                        _indexSelected = index;
                      } else if (_productoSelect[index] && _isSelect) {
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
                    //await wDialog(context).mostrar();
                  }),
              new ListTile(
                title: Text('Actualizar'),
                leading: Icon(Icons.update),
                onTap: () async {
                  //await wDialog(context).modificar();
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
                                  await producto
                                          .productoBorrar(producto.producto.id)
                                      ? print('producto borrado')
                                      : print('No se pudo borrar');
                                },
                                child: Text('SI')),
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('NO'))
                          ],
                          content:
                              Text('¿Seguro que quieres eliminar el producto?'),
                        );
                      });
                },
              ),
            ]),
          );
        },
        context: context);
  }
}
