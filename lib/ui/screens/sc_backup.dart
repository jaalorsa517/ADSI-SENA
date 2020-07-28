import 'package:flutter/material.dart';
import 'package:ventas/config/variables.dart';
import 'package:ventas/logic/backup/backup_logic.dart';

class ScBackup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScBackup();
  }
}

class _ScBackup extends State<ScBackup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Backup'), backgroundColor: colorGenerico),
      body: RaisedButton(
          child: Text('Backup'),
          color: colorGenerico,
          onPressed: () async {
            await BackUpLogic.backUpDo()
                .then((value) => print('Copia correcta'))
                .catchError((onError) => print('Error $onError'));
          }),
    );
  }
}
