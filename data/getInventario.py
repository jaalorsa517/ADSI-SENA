# -*- coding:utf-8 -*-

import sqlite3
import random as r


def load():
    _PATH_DB = '/home/jaalorsa/Proyectos/flutter/ventas/data/pedidoDB.db'
    print('INICIO PROCESO INVENTARIO')

    try:
        con = sqlite3.connect(_PATH_DB)
        cursor = con.cursor()

        cursor.execute("DELETE FROM inventario")
        cursor.execute("DELETE FROM inventario_producto")
        con.commit()

    except sqlite3.Error as e:
        print(type(e).__name__)

    finally:
        con.close()

    for id in range(1, r.randint(10, 50)):

        fecha = '{}-{}-{}'.format(r.randint(1, 31), r.randint(1, 13), 2020)

        cantidad = r.randint(0, 25)

        try:
            con = sqlite3.connect(_PATH_DB)
            cursor = con.cursor()

            cursor.execute(
                '''SELECT id FROM Producto ORDER BY id ASC LIMIT 1''')
            i = cursor.fetchone()[0]
            cursor.execute(
                '''SELECT id FROM Producto ORDER BY id DESC LIMIT 1''')
            f = cursor.fetchone()[0]

            idProducto = r.randint(i, f + 1)

            cursor.execute(
                '''SELECT id1 FROM cliente ORDER BY id1 ASC LIMIT 1''')
            i = cursor.fetchone()[0]
            cursor.execute(
                '''SELECT id1 FROM cliente ORDER BY id1 DESC LIMIT 1''')
            f = cursor.fetchone()[0]

            fkIdCliente = r.randint(i, f + 1)

            cursor.execute('''INSERT INTO inventario VALUES(
                {},{},'{}',{}
                )'''.format(id, cantidad, fecha, fkIdCliente))
            con.commit()

            cursor.execute('''INSERT INTO inventario_producto VALUES(
                {},{}
            )'''.format(id, idProducto))
            con.commit()

        except sqlite3.Error as e:
            print(type(e).__name__)

        finally:
            con.close()

    print('FIN PROCESO INVENTARIO')
