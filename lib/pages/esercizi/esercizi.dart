import 'package:flutter/material.dart';
import 'package:latinux/pages/esercizi/libri_list.dart';

class Esercizi extends StatefulWidget {
  Esercizi({Key key}) : super(key: key);

  @override
  _EserciziState createState() => _EserciziState();
}

class _EserciziState extends State<Esercizi> {
  @override
  Widget build(BuildContext context) {
    return LibriList();
  }
}
