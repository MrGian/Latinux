import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:latinux/database/database.dart';
import 'package:latinux/pages/dizionario/flessione.dart';
import 'package:latinux/styles/text.dart';

class Parola extends StatelessWidget {
  const Parola({Key key, this.lemma, this.grammatica, this.code})
      : super(key: key);

  final String lemma;
  final String grammatica;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dizionario', style: Styles.title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: LDatabase.getParola(code),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            if (snap.data == null)
              return Center(
                  child: Text(
                'Nessun risultato.\nControlla la connessione a internet',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
              ));
            else
              return Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Text(
                          lemma,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red, fontSize: 50),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      ),
                      getParadigma(snap.data['paradigma']),
                      Container(
                        child: Text(
                          grammatica,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      ),
                      getFlessioneButton(snap.data['flessione'], context),
                      Container(
                        child: Text(
                          'Traduzioni',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      ),
                      Container(
                        child: getHtml(snap.data['italiano']),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      ),
                      getCitazioni(snap.data['citazioni'])
                    ],
                  ),
                ),
              );
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget getParadigma(String data) {
    if (data.isEmpty)
      return Container(width: 0, height: 0);
    else
      return Container(
        child: Text(
          data,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontSize: 27),
        ),
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      );
  }

  Widget getFlessioneButton(String data, BuildContext context) {
    if (data.isEmpty || data.contains('>null'))
      return Container(width: 0, height: 0);
    else
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Flessione(data: data),
            ),
          );
        },
        child: Container(
          child: Text(
            'Tocca qui per vedere la declinazione/coniugazione',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                decoration: TextDecoration.underline,
                color: Colors.blue),
          ),
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        ),
      );
  }

  Widget getCitazioni(String input) {
    if (input.isEmpty)
      return Container(width: 0, height: 0);
    else
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                'Locuzioni e modi di dire',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            ),
            Container(
              child: getHtml(input),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            ),
          ]);
  }

  Html getHtml(String input) {
    input = ' - ' + input;
    List<String> list = input
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('\n', '<br><br> - ')
        .split('*');
    String output = '';
    for (int i = 0; i < list.length; i++) {
      if (i.isOdd) list[i] = '<strong>' + list[i] + '</strong>';
      output += list[i];
    }
    return Html(
        data: output.substring(0, output.length - 2),
        customTextStyle: (node, baseStyle) {
          return baseStyle.merge(TextStyle(fontSize: 17));
        });
  }
}
