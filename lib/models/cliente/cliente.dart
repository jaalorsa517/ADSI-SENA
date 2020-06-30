class Cliente {
  int _id;
  String _nit;
  String _nombre;
  String _representante;
  String _direccion;
  String _telefono;
  String _email;
  String _ciudad;

  Cliente(
      [this._id,
      this._nit,
      this._nombre,
      this._representante,
      this._direccion,
      this._telefono,
      this._email,
      this._ciudad]);

  int get id => _id;

  set id(int id) => this._id = id;

  String get nit => _nit;

  set nit(String value) => _nit = value;

  String get nombre => _nombre;

  set nombre(String value) => _nombre = value;

  String get representante => _representante;

  set representante(String value) => _representante = value;

  String get direccion => _direccion;

  set direccion(String value) => _direccion = value;

  String get telefono => _telefono;

  set telefono(String value) => _telefono = value;

  String get email => _email;

  set email(String value) => _email = value;

  String get ciudad => _ciudad;

  set ciudad(String value) => _ciudad = value;
}
