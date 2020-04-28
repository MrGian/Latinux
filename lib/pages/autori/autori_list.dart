import 'package:flutter/material.dart';
import 'package:latinux/database/database.dart';
import 'package:latinux/pages/autori/autore_card.dart';

class AutoriList extends StatelessWidget {
  const AutoriList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: LDatabase.autori.length + 1,
      itemBuilder: (context, index) {
        if (index == LDatabase.autori.length)
          return Container(height: 45, color: Colors.white);
        else
          return AutoreCard(index: index);
      },
    ));
  }
}
