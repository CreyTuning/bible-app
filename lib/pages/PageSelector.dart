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
      return Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Inicio'),
          Text('En desarrollo...', style: Theme.of(context).textTheme.body1)
        ],
      ));
    else if(widget.index == 1)
      return BiblePage();
    else if(widget.index == 2)
      return Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Aprender'),
          Text('En desarrollo...', style: Theme.of(context).textTheme.body1)
        ],
      ));
  }
}
