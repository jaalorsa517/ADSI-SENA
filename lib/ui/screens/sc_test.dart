import 'package:edertiz/config/utilidades.dart';
import 'package:edertiz/test/integrals/integracion_cliente.dart';
import 'package:edertiz/test/integrals/integracion_producto.dart';
import 'package:edertiz/test/units/producto_test.dart';
import 'package:flutter/material.dart';
import 'package:edertiz/test/units/cliente_test.dart';

class ScTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              color: colorGenerico,
              child: Text("TESTS..."),
              onPressed: () async {
                await new Cliente_test().start();
                await new Producto_test().start();
                await new IntegracionCliente().start();
                await new IntegracionProducto().start();
              },
            ),
          ],
        ),
      ),
    );
  }
}
