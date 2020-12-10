# -*- coding:utf-8 -*-

import get_ciudades as ciudad
import get_clientes as cliente
import get_productos as producto
import get_inventario as inventario
import get_pedido as pedido

if __name__ == "__main__":
    producto.load()
    ciudad.load()
    cliente.load()
    inventario.load()
    pedido.load()
