import "package:flutter/material.dart";

class wgridview extends StatefulWidget {
  final List<Widget> _data;
  final int _column;

  wgridview(this._column, this._data, {Key key}) : super(key: key);

  @override
  _wgridviewState createState() => _wgridviewState();
}

class _wgridviewState extends State<wgridview> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: this.widget._column,children:this.widget._data);
  }
}
