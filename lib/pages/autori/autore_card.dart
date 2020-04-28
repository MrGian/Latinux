import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latinux/database/database.dart';
import 'package:latinux/pages/autori/autore.dart';
import 'package:latinux/styles/text.dart';

class AutoreCard extends StatelessWidget {
  const AutoreCard({Key key, this.index}) : super(key: key);

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
            CircleAvatar(
                radius: 25,
                backgroundImage: MemoryImage(
                    base64.decode(LDatabase.autori[index]['IMMAGINI']))),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(LDatabase.autori[index]['AUTORE'],
                    style: Styles.autore))
          ],
        ),
      ),
    );
  }

  onTap(int index, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Autore(index: index)));
  }
}
