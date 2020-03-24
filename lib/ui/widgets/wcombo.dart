import "package:flutter/material.dart";
import "dart:async";

class wcombo extends StatefulWidget {
  List<String> list;
  StreamController _stream;
  List items;

  wcombo(this.list, this._stream, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _wcombo(this.list, this._stream);
}

class _wcombo extends State<wcombo> {
  final List<String> list;
  String _selection;
  StreamController _stream;
  List items;

  _wcombo(this.list, this._stream) {
    //this._selection = this.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return new DropdownButton(
        hint: Text('SELECCIONE UNO'),
        value: this._selection,
        items: this
            .list
            .map((d) => new DropdownMenuItem(child: Text(d), value: d))
            .toList(),
        onChanged: (value) {
          setState(() {
            this._selection = value;
            this._stream.add(value);
          });
        });
  }
}
