import "package:flutter/material.dart";

class wgridview extends StatefulWidget {
  final List<Widget> _data;
  final int _column;

  wgridview(this._column, this._data);

  @override
  _wgridviewState createState() => _wgridviewState();
}

class _wgridviewState extends State<wgridview> {
  @override
  Widget build(BuildContext context) {
    return _gridview(this.widget._column, this.widget._data);
  }

  Widget _gridview(int column, List<Widget> data) {
    return GridView.count(
      crossAxisCount: column,
      children: data,
    );
  }
}
