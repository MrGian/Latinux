import 'package:flutter/material.dart';
import 'package:latinux/database/database.dart';
import 'package:latinux/pages/esercizi/libro_card.dart';

class LibriList extends StatelessWidget {
  const LibriList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: LDatabase.libri.length + 1,
      itemBuilder: (context, index) {
        if (index == LDatabase.libri.length)
          return Container(height: 45, color: Colors.white);
        else
          return LibroCard(index: index);
      },
    ));
  }
}
