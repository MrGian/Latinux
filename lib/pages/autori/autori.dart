import 'package:flutter/material.dart';
import 'package:latinux/pages/autori/autori_list.dart';

class Autori extends StatefulWidget {
  Autori({Key key}) : super(key: key);

  @override
  _AutoriState createState() => _AutoriState();
}

class _AutoriState extends State<Autori> {
  @override
  Widget build(BuildContext context) {
    return AutoriList();
  }
}
