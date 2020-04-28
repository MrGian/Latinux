import 'package:flutter/material.dart';
import 'package:latinux/database/database.dart';
import 'package:latinux/styles/text.dart';

class Esercizio extends StatelessWidget {
  const Esercizio({Key key, this.nome}) : super(key: key);

  final String nome;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LDatabase.getEsercizio(nome),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          var title = nome.split(' → ')[0].split(' | ')[1];
          return Scaffold(
            appBar: AppBar(
              title: Text(title, style: Styles.title),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  snap.data.first['TESTO'].replaceAll('\n', '\n\n'),
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
