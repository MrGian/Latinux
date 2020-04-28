import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:latinux/database/database.dart';
import 'package:latinux/pages/esercizi/libro.dart';
import 'package:latinux/styles/text.dart';

class LibroCard extends StatelessWidget {
  const LibroCard({Key key, this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index, context),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.memory(
                  base64.decode(LDatabase.libri[index]['COPERTINA'])),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: AutoSizeText(LDatabase.libri[index]['NOME'],
                      style: Styles.autore, maxLines: 2)),
            )
          ],
        ),
      ),
    );
  }

  onTap(int index, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Libro(libro: LDatabase.libri[index]['NOME'])));
  }
}
