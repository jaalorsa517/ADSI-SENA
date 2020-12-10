# -*- coding:utf-8 -*-

import sqlite3
import random as r


def load():
    _PATH_DB = '/home/jaalorsa/Proyectos/flutter/ventas/data/pedidoDB.db'
    print('INICIO PROCESO INVENTARIO')
    _id = 0

    try:
        con = sqlite3.connect(_PATH_DB)
        cursor = con.cursor()

        if (cursor.fetchone() is None):
            _id=0
        else:
            cursor.execute(
                '''SELECT id FROM inventario ORDER BY id DESC LIMIT 1;''')
            _id = cursor.fetchone()[0]

    except sqlite3.Error as e:
        print(type(e).__name__)

    finally:
        con.close()

    for id in range(_id+1, r.randint(_id+1, 10000)):

        fecha = '{}-{}-{}'.format(2020,r.randint(1,12),r.randint(1, 28))

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

            idProducto = r.randint(i, f)

            cursor.execute(
                '''SELECT id FROM cliente ORDER BY id ASC LIMIT 1''')
            i = cursor.fetchone()[0]
            cursor.execute(
                '''SELECT id FROM cliente ORDER BY id DESC LIMIT 1''')
            f = cursor.fetchone()[0]

            fkIdCliente = r.randint(i, f)

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
