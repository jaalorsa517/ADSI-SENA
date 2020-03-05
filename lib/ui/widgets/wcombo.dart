import "package:flutter/material.dart";

class wcombo extends StatefulWidget {
  final List<String> list;

  wcombo(this.list);

  @override
  State<StatefulWidget> createState() {
    return _wcombo(this.list);
  }
}

class _wcombo extends State<wcombo> {
  final List<String> list;
  String _selection;

  _wcombo(this.list) {
    this._selection = this.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        hint: Text('Productos'),
        icon: Icon(Icons.arrow_downward),
        items: this
            .list
            .map((String item) =>
                new DropdownMenuItem(child: Text(item), value: item))
            .toList(),
        value: this._selection,
        onChanged: (value) {
          setState(() {
            this._selection = value;
            print(this._selection);
          });
        });
  }
}
