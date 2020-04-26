import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            RichText(text: TextSpan(text: 'YHWH', style: TextStyle(fontFamily: 'Londrina', letterSpacing: 4, fontSize: 30, color: Theme.of(context).appBarTheme.textTheme.title.color)),),
            RichText(text: TextSpan(text: 'יהוה', style: TextStyle(fontFamily: 'Tinos', letterSpacing: 2.5, fontSize: 18, height: 0.6, color: Theme.of(context).appBarTheme.textTheme.title.color)), textAlign: TextAlign.right,),
          ],
        )
      ),
    );
  }
}


