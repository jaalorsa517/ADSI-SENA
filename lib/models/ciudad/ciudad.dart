class Ciudad {
  int _id;
  String _nombre;

  // ignore: unnecessary_getters_setters
  int get id => _id;

  // ignore: unnecessary_getters_setters
  set id(int value) => _id = value;

  // ignore: unnecessary_getters_setters
  String get nombre => _nombre;

  // ignore: unnecessary_getters_setters
  set nombre(String value) => _nombre = value;

  Ciudad([this._id, this._nombre]);
}
