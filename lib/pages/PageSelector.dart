import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/pages/BiblePage/BiblePage.dart';
import 'package:yhwh/pages/HomePage/HomePage.dart';

class PageSelector extends StatefulWidget {
  int index;
  PageSelector({this.index});

  _PageSelectorState createState() => _PageSelectorState();

}

class _PageSelectorState extends State<PageSelector>{

  @override
  Widget build(BuildContext context) {
    if(widget.index == 0)
      return EnDesarrollo(title: 'Inicio');
    else if(widget.index == 1)
      return BiblePage();
    else if(widget.index == 2)
      return EnDesarrollo(title: 'Aprender');
    else if(widget.index == 3)
      return EnDesarrollo(title: 'Favoritos');
    else if(widget.index == 4)
      return EnDesarrollo(title: 'Ovejas');
  }
}

class EnDesarrollo extends StatelessWidget{
  String title;
  EnDesarrollo({this.title});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(this.title),
        Divider(color: Colors.transparent),
        Text('En desarrollo', style: TextStyle(
          color: Theme.of(context).textTheme.body1.color,
          fontSize: 15
        ))
      ],
    ));
  }
}