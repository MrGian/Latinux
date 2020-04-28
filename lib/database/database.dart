import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
//import 'package:permission/permission.dart';
import 'package:sqflite/sqflite.dart';

class LDatabase {
  static Database database;
  static List<Map> libri;
  static List<Map> autori;
  static List<Map> lemmi;

  static Future<void> init() async {
    var dbdir = await getDatabasesPath();
    var dbpath = dbdir + '/esercizi.db';
    File file = File(dbpath);
    bool exist = await file.exists();
    if (!exist) {
      ByteData data = await rootBundle.load("assets/database/esercizi.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbpath).writeAsBytes(bytes);
    }

    database = await openDatabase(dbpath);
    libri = await database.rawQuery('SELECT * FROM LIBRI');
    autori = await database.rawQuery('SELECT * FROM SINTESI');
    lemmi = await database.rawQuery('SELECT * FROM LEMMI');

    //await addData();
  }

  static Future<List<Map>> getEsercizi(String libro) async {
    return await database.rawQuery(
        'SELECT NOME FROM ESERCIZI WHERE LIBRO = ? ORDER BY PAGINA, NUMERO',
        [libro]);
  }

  static Future<List<Map>> getEsercizio(String nome) async {
    return await database
        .rawQuery('SELECT TESTO FROM ESERCIZI WHERE NOME = ?', [nome]);
  }

  static Future<Map> getParola(String code) async {
    var doc =
        await Firestore.instance.collection('dizionario').document(code).get();
    return doc.data;
  }

  /*static addData() async {
    var permissionNames =
        await Permission.requestPermissions([PermissionName.Storage]);

    var path = '/storage/emulated/0/dizionario.db';
    Database db = await openDatabase(path);

    for (int i = 59501; i <= 76500; i++) {
      List<Map> list = await db
          .rawQuery('SELECT * FROM DIZIONARIO WHERE rowid = ?', [i.toString()]);
      Map<String, dynamic> map = new Map<String, dynamic>();
      map['paradigma'] = list.first['PARADIGMA'];
      map['italiano'] = list.first['ITALIANO'];
      map['citazioni'] = list.first['CITAZIONI'];
      map['flessione'] = list.first['FLESSIONE'];
      map['index'] = i.toString();
      await Firestore.instance
          .collection('dizionario')
          .document(lemmi[i - 1]['CODE'])
          .setData(map);
      print(i);
    }
  }*/
}
