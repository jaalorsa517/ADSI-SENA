# -*- coding:utf-8 -*-

import getCiudades as ciudad
import getClientes as cliente
import getProductos as producto
import getInventario as inventario
import getPedido as pedido

if __name__ == "__main__":
    producto.load()
    ciudad.load()
    cliente.load()
    inventario.load()
    pedido.load()
