import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:latinux/database/database.dart';
import 'package:latinux/pages/dizionario/result.dart';

class Dizionario extends StatefulWidget {
  Dizionario({Key key}) : super(key: key);

  @override
  _DizionarioState createState() => _DizionarioState();
}

class _DizionarioState extends State<Dizionario> {
  String query = '';

  bool searched = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: query);

    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          title: new TextField(
            textInputAction: TextInputAction.search,
            controller: controller,
            decoration:
                new InputDecoration.collapsed(hintText: 'Cerca una parola...'),
            style: Theme.of(context).textTheme.title,
            onSubmitted: (String text) {
              setState(() {
                searched = true;
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
        body: getBody());
  }

  getBody() {
    if (searched)
      return FutureBuilder(
        future: search(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.length == 0)
              return Center(
                  child: Text(
                'Nessun risultato.\nControlla la parola inserita',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
              ));
            else
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Result(
                    lemma: snapshot.data[index]['lemma'],
                    grammatica: snapshot.data[index]['grammatica'],
                    nome: snapshot.data[index]['nome'],
                    code: snapshot.data[index]['code'],
                    index: index,
                  );
                },
              );
          } else
            return Center(child: CircularProgressIndicator());
        },
      );
    else
      return ListView.builder(
        itemCount: LDatabase.lemmi.length,
        itemBuilder: (context, index) {
          return Result(
            lemma: LDatabase.lemmi[index]['LEMMA'],
            grammatica: LDatabase.lemmi[index]['GRAMMATICA'],
            nome: LDatabase.lemmi[index]['NOME'],
            code: LDatabase.lemmi[index]['CODE'],
            index: index,
          );
        },
      );
  }

  Future<List<Map>> search(String queryy) async {
    List<Map<String, String>> risultati = [];
    for (int i = 0; i < LDatabase.lemmi.length; i++) {
      if (LDatabase.lemmi[i]['NOME'].toLowerCase() ==
          removeDiacritics(queryy).toLowerCase()) {
        risultati.add({
          'lemma': LDatabase.lemmi[i]['LEMMA'],
          'nome': LDatabase.lemmi[i]['NOME'],
          'grammatica': LDatabase.lemmi[i]['GRAMMATICA'],
          'code': LDatabase.lemmi[i]['CODE']
        });
      }
    }

    for (int i = 0; i < LDatabase.lemmi.length; i++) {
      if (LDatabase.lemmi[i]['NOME']
              .toLowerCase()
              .startsWith(removeDiacritics(queryy).toLowerCase()) &&
          LDatabase.lemmi[i]['NOME'].toLowerCase() !=
              removeDiacritics(queryy).toLowerCase()) {
        risultati.add({
          'lemma': LDatabase.lemmi[i]['LEMMA'],
          'nome': LDatabase.lemmi[i]['NOME'],
          'grammatica': LDatabase.lemmi[i]['GRAMMATICA'],
          'code': LDatabase.lemmi[i]['CODE']
        });
      }
    }

    for (int i = 0; i < LDatabase.lemmi.length; i++) {
      if (LDatabase.lemmi[i]['NOME']
              .toLowerCase()
              .contains(removeDiacritics(queryy).toLowerCase()) &&
          !LDatabase.lemmi[i]['NOME']
              .toLowerCase()
              .startsWith(removeDiacritics(queryy).toLowerCase()) &&
          LDatabase.lemmi[i]['NOME'].toLowerCase() !=
              removeDiacritics(queryy).toLowerCase()) {
        risultati.add({
          'lemma': LDatabase.lemmi[i]['LEMMA'],
          'nome': LDatabase.lemmi[i]['NOME'],
          'grammatica': LDatabase.lemmi[i]['GRAMMATICA'],
          'code': LDatabase.lemmi[i]['CODE']
        });
      }
    }

    return risultati;
  }
}
