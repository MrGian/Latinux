import 'dart:io';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latinux/database/database.dart';
import 'package:latinux/icons/roman_icons.dart';
import 'package:latinux/pages/autori/autori.dart';
import 'package:latinux/pages/dizionario/dizionario.dart';
import 'package:latinux/pages/esercizi/esercizi.dart';
import 'package:latinux/pages/info/info.dart';
import 'package:latinux/styles/text.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latinux',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: FutureBuilder(
        future: LDatabase.init(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done)
            return Main();
          else
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
        },
      ),
    );
  }
}

class Main extends StatefulWidget {
  Main({Key key}) : super(key: key);

  @override
  _Main createState() => _Main();
}

class _Main extends State<Main> with TickerProviderStateMixin {
  static const platform = const MethodChannel('flutter.native/helper');

  @override
  void initState() {
    super.initState();
    if(Platform.isAndroid){
      platform.setMethodCallHandler(handler);
      platform.invokeMethod('checkLicense');
    }
  }

  Future<dynamic> handler(MethodCall methodCall) async {
    if (methodCall.method == 'sendLicense') {
      if (!methodCall.arguments.contains('YES'))
        showLicenseDialog(methodCall.arguments);
    }
  }

  showLicenseDialog(String text) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              content: Text(
                  "Impossibile verificare  l'acquisto dell'app.\nControlla tua connessione a internet e riprova\n\nSe non lo hai ancora fatto acquista l'app dal Play Store.\n\nERRORE: " +
                      text),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    exit(0);
                  },
                )
              ],
            );
          });
    });
  }

  int index = 2;

  TabController tabController;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: index,
    );

    return Container(
      child: Scaffold(
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Roman.medallion, title: 'Autori'),
            TabData(iconData: Roman.open_book, title: 'Dizionario'),
            TabData(iconData: Roman.scroll, title: 'Esercizi'),
            TabData(iconData: Roman.information_button, title: 'Info'),
          ],
          initialSelection: index,
          onTabChangedListener: (pos) {
            setState(() {
              index = pos;
              tabController.animateTo(index);
            });
          },
        ),
        appBar: AppBar(
          title: Text(getTitle(), style: Styles.title),
          centerTitle: true,
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            Autori(),
            Dizionario(),
            Esercizi(),
            Info(),
          ],
        ),
      ),
    );
  }

  String getTitle() {
    switch (index) {
      case 0:
        return 'Autori';
        break;
      case 1:
        return 'Dizionario';
        break;
      case 2:
        return 'Esercizi';
        break;
      case 3:
        return 'Info';
        break;
      default:
        return 'Latinux';
    }
  }
}
