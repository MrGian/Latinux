import 'package:flutter/material.dart';
import 'package:latinux/pages/dizionario/parola.dart';

class Result extends StatelessWidget {
  const Result(
      {Key key, this.lemma, this.grammatica, this.index, this.nome, this.code})
      : super(key: key);

  final String lemma;
  final String grammatica;
  final String code;
  final int index;
  final String nome;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Parola(
              lemma: lemma,
              grammatica: grammatica,
              code: code,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(lemma, style: TextStyle(fontSize: 20)),
            Text(grammatica, style: TextStyle(fontSize: 15, color: Colors.grey))
          ],
        ),
      ),
    );
  }
}
