import "package:flutter/material.dart";

class wcombo extends StatefulWidget {
  List<String> list;
  wcombo(this.list);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _wcombo(list);
  }
}

class _wcombo extends State<wcombo> {
  List<String> list;
  _wcombo(this.list);
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: this.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
