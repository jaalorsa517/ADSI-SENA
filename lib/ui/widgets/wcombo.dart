import "package:flutter/material.dart";

class wcombo extends StatefulWidget {
  List<String> list;
  wcombo(this.list);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _wcombo(this.list);
  }
}

class _wcombo extends State<wcombo> {
  List<String> list;
  String dropdownValue;
  
  _wcombo(this.list) {
    this.dropdownValue = list[0];
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownButton<String>(
      value: this.dropdownValue,
      icon: Icon(Icons.arrow_downward),
      onChanged: (String newValue) {
        setState(() {
          this.dropdownValue = newValue;
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
