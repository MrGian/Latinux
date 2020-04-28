import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:latinux/styles/text.dart';

class Flessione extends StatelessWidget {
  const Flessione({Key key, this.data}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text('Flessione', style: Styles.title),
        centerTitle: true,
      ),
      url: Uri.dataFromString(
              data
                  .replaceAll('Vedi la forma attiva di questo lemma', '')
                  .replaceAll('Vedi la forma passiva di questo lemma', ''),
              mimeType: 'text/html',
              encoding: utf8)
          .toString(),
    );
  }
}
