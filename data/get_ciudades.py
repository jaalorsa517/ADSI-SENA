# -*- coding:utf-8 -*-

import sqlite3

from sqlite3 import Error


def load():
    _CIUDADES = ('ANDES', 'BETANIA', 'HISPANIA', 'JARDIN', 'SANTA INES',
                 'SANTA RITA', 'TAPARTO')
    _PATH_DB = '/home/jaalorsa/Proyectos/flutter/ventas/data/pedidoDB.db'
    _ID = 1

    print('INICIÓ PROCESO DE CIUDADES')
    n = 0
    try:
        conexion = sqlite3.connect(_PATH_DB)
        conexion.execute("DELETE FROM ciudad")
        conexion.commit()

        for ciudad in _CIUDADES:
            conexion.execute("INSERT INTO ciudad VALUES({},'{}')".format(
                _ID + n, ciudad))
            conexion.commit()
            n += 1

        print('TERMINO PROCESO DE CIUDADES')

    except Error:
        print(type(Error).__name__)
        conexion.close()

    finally:
        conexion.close()