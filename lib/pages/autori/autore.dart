import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:latinux/database/database.dart';
import 'package:latinux/styles/text.dart';

class Autore extends StatelessWidget {
  const Autore({Key key, this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    Map autore = LDatabase.autori[index];

    return Scaffold(
      appBar: AppBar(
        title: Text(autore['AUTORE'], style: Styles.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: getText(autore['TESTO'])),
    );
  }

  Html getText(String text) {
    List<String> lines = text.split('\n');
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains('*'))
        lines[i] = lines[i].replaceAll('*', '<strong>') + '</strong><br>';
    }

    String htmltext = '';
    for (var line in lines) {
      htmltext += line + '<br>';
    }

    return Html(
      data: htmltext,
      padding: EdgeInsets.all(10),
      customTextStyle: (node, baseStyle) {
        return baseStyle.merge(TextStyle(fontSize: 20));
      },
    );
  }
}
