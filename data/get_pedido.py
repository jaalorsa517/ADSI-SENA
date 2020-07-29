# -*- coding:utf-8 -*-

import sqlite3
import random as r


def load():
    _PATH_DB = '/home/jaalorsa/Proyectos/flutter/ventas/data/pedidoDB.db'
    print('INICIO PROCESO PEDIDO')

    try:
        con = sqlite3.connect(_PATH_DB)
        cursor = con.cursor()
        cursor.execute("DELETE FROM pedido")

    except sqlite3.Error as e:
        print(type(e).__name__)

    finally:
        con.close()

    try:
        con = sqlite3.connect(_PATH_DB)
        cursor = con.cursor()

        #id,fecha_pedido,fecha_entrega,id_inventario, cantidad, valor, id_cliente

        for id in range(1, r.randint(10, 80)):

            d = r.randint(1, 31)
            m = r.randint(1, 13)
            fecha_pedido = '{}-{}-{}'.format(d, m, 2020)
            fecha_entrega = '{}-{}-{}'.format(d + 1, m, 2020)

            cantidad = r.randint(1, 30)
            valor = r.randint(1, 30) * 1000

            cursor.execute(
                '''SELECT id FROM inventario ORDER BY id ASC LIMIT 1''')
            i = cursor.fetchone()[0]
            cursor.execute(
                '''SELECT id FROM inventario ORDER BY id DESC LIMIT 1''')
            f = cursor.fetchone()[0]

            id_inventario = r.randint(i, f + 1)

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