# -*- coding:utf-8 -*-

import sqlite3
import random as r


def load():
    _PATH_DB = '/home/jaalorsa/Proyectos/flutter/ventas/data/pedidoDB.db'
    print('INICIO PROCESO PEDIDO')
    _id = 0

    try:
        con = sqlite3.connect(_PATH_DB)
        cursor = con.cursor()

        if (cursor.fetchone() is None):
            _id=0
        else:
            cursor.execute(
                '''SELECT id FROM pedido ORDER BY id DESC LIMIT 1''')
            _id = cursor.fetchone()[0]

    except sqlite3.Error as e:
        print(type(e).__name__)

    finally:
        con.close()

    try:
        con = sqlite3.connect(_PATH_DB)
        cursor = con.cursor()

        #id,fecha_pedido,fecha_entrega,id_inventario, cantidad, valor, id_cliente

        for id in range(_id+1, r.randint(_id+1, 10000)):

            d = r.randint(1, 28)
            m = r.randint(1, 12)
            fecha_pedido = '{}-{}-{}'.format(2020, m, d)
            fecha_entrega = '{}-{}-{}'.format(2020, m, d + 1)

            cantidad = r.randint(1, 30)
            valor = r.randint(1, 30) * 1000

            cursor.execute(
                '''SELECT id FROM inventario ORDER BY id ASC LIMIT 1''')
            i = cursor.fetchone()[0]
            cursor.execute(
                '''SELECT id FROM inventario ORDER BY id DESC LIMIT 1''')
            f = cursor.fetchone()[0]

            id_inventario = r.randint(i, f)

            cursor.execute("""INSERT INTO pedido VALUES 
                ({},'{}','{}',{},{},{}
                )""".format(id, fecha_pedido, fecha_entrega, id_inventario,
                            cantidad, valor))

            con.commit()

    except sqlite3.Error as e:
        print(type(e).__name__)

    finally:
        con.close()
    print('FIN PROCESO PEDIDO')
