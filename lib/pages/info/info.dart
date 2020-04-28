import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Info extends StatefulWidget {
  Info({Key key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(50),
          child: SvgPicture.asset(
            'assets/images/latinux.svg',
            height: 60,
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 50),
          child: Text(
            'v 3.0.3',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 60),
          child: Text(
            'Sviluppata da Gianmatteo Palmieri',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 30),
          child: Text(
            'Contatti',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            'Email:\ngianmatteo.palmieri@gmail.com',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            'Instagram:\n@latinux_app\n@im_gian',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
