import 'package:flutter/material.dart';
import 'package:latinux/database/database.dart';
import 'package:latinux/pages/esercizi/result.dart';
import 'package:latinux/styles/text.dart';

class Libro extends StatefulWidget {
  Libro({Key key, this.libro}) : super(key: key);

  final String libro;

  @override
  _LibroState createState() => _LibroState();
}

class _LibroState extends State<Libro> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: query);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.libro, style: Styles.title),
          centerTitle: true,
        ),
        body: Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.white,
            title: new TextField(
              textInputAction: TextInputAction.search,
              controller: controller,
              decoration: new InputDecoration.collapsed(
                  hintText: 'Cerca un esercizio...'),
              style: Theme.of(context).textTheme.title,
              onSubmitted: (String text) {
                setState(() {
                  query = text;
                });
              },
            ),
            actions: [
              new IconButton(
                icon: new Icon(Icons.clear),
                color: Colors.grey,
                onPressed: () {
                  setState(() {
                    query = '';
                  });
                },
              ),
            ],
          ),
          body: FutureBuilder(
            future: search(query, widget.libro),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done)
                return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (context, index) {
                    return Result(
                      nome: snap.data[index]['NOME'],
                    );
                  },
                );
              else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }

  Future<List<Map>> search(String queryy, String libro) async {
    List<Map> results = [];
    List<Map> esercizi = await LDatabase.getEsercizi(libro);

    for (var esercizio in esercizi) {
      if (contains(esercizio['NOME'], queryy)) results.add(esercizio);
    }

    return results;
  }

  bool contains(String testo, String queryyy) {
    List<String> parole = queryyy.toLowerCase().split(' ');
    for (var parola in parole)
      if (!testo.toLowerCase().contains(parola)) return false;

    return true;
  }
}
