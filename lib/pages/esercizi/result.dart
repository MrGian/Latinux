import 'package:flutter/material.dart';
import 'package:latinux/pages/esercizi/esercizio.dart';

class Result extends StatelessWidget {
  const Result({Key key, this.nome}) : super(key: key);

  final String nome;

  @override
  Widget build(BuildContext context) {
    var first = nome.split(' → ')[0].split(' | ')[1];
    var second = nome.split(' → ')[1];
    var third = nome.split(' | ')[0];

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Esercizio(nome: nome)));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(first, style: TextStyle(fontSize: 20)),
            Text(second,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold)),
            Text(third, style: TextStyle(fontSize: 15, color: Colors.grey))
          ],
        ),
      ),
    );
  }
}
