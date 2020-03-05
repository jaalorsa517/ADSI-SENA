# -*- coding:utf-8 -*-

import getCiudades as ciudad
import getClientes as cliente
import getProductos as producto

if __name__ == "__main__":
    producto.load()
    ciudad.load()
    cliente.load()