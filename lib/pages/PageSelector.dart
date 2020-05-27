import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/pages/BiblePage/BiblePage.dart';

class PageSelector extends StatelessWidget{
  PageSelector({@required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {

    Widget page;

    switch (index) {
      case 0:
        page = EnDesarrollo(title: 'Inicio');
        break;
      case 1:
        page = BiblePage();
        break;
      case 2:
        page = EnDesarrollo(title: 'Aprender');
        break;
      case 3:
        page = EnDesarrollo(title: 'Favoritos');
        break;
      case 4:
        page = EnDesarrollo(title: 'Ovejas');
        break;
      default:
    }

    return page;
  }
}

class EnDesarrollo extends StatelessWidget{
  EnDesarrollo({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.settings, size: 59.0,),
        Divider(color: Colors.transparent),
        Text(this.title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text('En desarrollo', style: TextStyle(
          color: Theme.of(context).textTheme.bodyText2.color,
          fontSize: 15,
          fontStyle: FontStyle.italic
        )),
      ],
    ));
  }
}