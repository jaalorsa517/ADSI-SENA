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

  // ignore: unnecessary_getters_setters
  String get nit => _nit;

  // ignore: unnecessary_getters_setters
  set nit(String value) => _nit = value;

  // ignore: unnecessary_getters_setters
  String get nombre => _nombre;

  // ignore: unnecessary_getters_setters
  set nombre(String value) => _nombre = value;

  // ignore: unnecessary_getters_setters
  String get representante => _representante;

  // ignore: unnecessary_getters_setters
  set representante(String value) => _representante = value;

  // ignore: unnecessary_getters_setters
  String get direccion => _direccion;

  // ignore: unnecessary_getters_setters
  set direccion(String value) => _direccion = value;

  // ignore: unnecessary_getters_setters
  String get telefono => _telefono;

  // ignore: unnecessary_getters_setters
  set telefono(String value) => _telefono = value;

  // ignore: unnecessary_getters_setters
  String get email => _email;

  // ignore: unnecessary_getters_setters
  set email(String value) => _email = value;

  // ignore: unnecessary_getters_setters
  String get ciudad => _ciudad;

  // ignore: unnecessary_getters_setters
  set ciudad(String value) => _ciudad = value;
}
