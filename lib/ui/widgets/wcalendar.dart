import 'package:flutter/material.dart';

class wcalendar extends StatefulWidget {
  String text;

  wcalendar(this.text);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _wcalendar(text);
  }
}

class _wcalendar extends State<wcalendar> {
  
  DateTime selected = DateTime.now();
  String text;

  _wcalendar(this.text);

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selected,
        firstDate: DateTime(2020),
        lastDate: DateTime(2021));

    if (picked != null && picked != selected) {
      setState(() {
        selected = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      child: Text(this.text),
      onPressed: () => _selectDate(context));
  }
}
