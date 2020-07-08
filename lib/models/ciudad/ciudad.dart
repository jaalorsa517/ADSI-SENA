class Ciudad {
  int _id;
  String _nombre;

  int get id => _id;

  set id(int value) => _id = value;

  String get nombre => _nombre;

  set nombre(String value) => _nombre = value;

  Ciudad([this._id, this._nombre]);
}
